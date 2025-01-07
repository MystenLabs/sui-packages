module 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::venue {
    struct VenueAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Venue has store, key {
        id: 0x2::object::UID,
        active: bool,
        min_duration: u64,
        max_duration: u64,
    }

    struct FeeSchedule<phantom T0> has store {
        price: u64,
    }

    struct FeeProceedsKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeScheduleKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Venue{
            id           : 0x2::object::new(arg2),
            active       : false,
            min_duration : arg0,
            max_duration : arg1,
        };
        0x2::transfer::share_object<Venue>(v0);
        let v1 = VenueAdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<VenueAdminCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun activate_raffle<T0, T1>(arg0: &mut Venue, arg1: &mut 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::raffle::Raffle<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::raffle::RaffleAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        activate_raffle_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun create_raffle<T0>(arg0: &mut Venue, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_duration(arg0, arg1);
        let (v0, v1) = 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::raffle::create_raffle<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_share_object<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::raffle::Raffle<T0>>(v0);
        0x2::transfer::public_transfer<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::raffle::RaffleAdminCap>(v1, 0x2::tx_context::sender(arg6));
    }

    fun activate_raffle_<T0, T1>(arg0: &mut Venue, arg1: &mut 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::raffle::Raffle<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::raffle::RaffleAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::raffle::activate_raffle<T0>(arg1, arg3, arg4, arg5);
        pay_fee_<T0>(arg0, arg2, arg5);
    }

    public entry fun activate_venue(arg0: &VenueAdminCap, arg1: &mut Venue) {
        assert_inactive(arg1);
        arg1.active = true;
    }

    public fun assert_active(arg0: &Venue) {
        assert!(arg0.active, 1);
    }

    public fun assert_duration(arg0: &Venue, arg1: u64) {
        assert!(arg1 >= arg0.min_duration, 3);
        assert!(arg1 <= arg0.max_duration, 4);
    }

    public fun assert_inactive(arg0: &Venue) {
        assert!(!arg0.active, 2);
    }

    public entry fun deactivate_venue(arg0: &VenueAdminCap, arg1: &mut Venue) {
        assert_active(arg1);
        arg1.active = false;
    }

    public fun fee_proceeds<T0>(arg0: &Venue) : &0x2::coin::Coin<T0> {
        0x2::dynamic_field::borrow<FeeProceedsKey<T0>, 0x2::coin::Coin<T0>>(&arg0.id, fee_proceeds_key<T0>())
    }

    public fun fee_proceeds_key<T0>() : FeeProceedsKey<T0> {
        FeeProceedsKey<T0>{dummy_field: false}
    }

    fun fee_proceeds_mut<T0>(arg0: &mut Venue) : &mut 0x2::coin::Coin<T0> {
        0x2::dynamic_field::borrow_mut<FeeProceedsKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, fee_proceeds_key<T0>())
    }

    public fun fee_schedule_key<T0>() : FeeScheduleKey<T0> {
        FeeScheduleKey<T0>{dummy_field: false}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new(43200000, 172800000, arg0);
    }

    public fun is_active(arg0: &Venue) : bool {
        arg0.active
    }

    fun pay_fee_<T0>(arg0: &mut Venue, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_with_type<FeeScheduleKey<T0>, FeeSchedule<T0>>(&arg0.id, fee_schedule_key<T0>())) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
            abort 5
        };
        if (!0x2::dynamic_field::exists_with_type<FeeProceedsKey<T0>, 0x2::coin::Coin<T0>>(&arg0.id, fee_proceeds_key<T0>())) {
            0x2::dynamic_field::add<FeeProceedsKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, fee_proceeds_key<T0>(), arg1);
        } else {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<FeeProceedsKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, fee_proceeds_key<T0>()), arg1);
        };
    }

    public entry fun set_fee<T0>(arg0: &VenueAdminCap, arg1: &mut Venue, arg2: u64) {
        set_fee_<T0>(arg1, arg2);
    }

    fun set_fee_<T0>(arg0: &mut Venue, arg1: u64) {
        if (!0x2::dynamic_field::exists_with_type<FeeScheduleKey<T0>, FeeSchedule<T0>>(&arg0.id, fee_schedule_key<T0>())) {
            let v0 = FeeSchedule<T0>{price: arg1};
            0x2::dynamic_field::add<FeeScheduleKey<T0>, FeeSchedule<T0>>(&mut arg0.id, fee_schedule_key<T0>(), v0);
        } else {
            0x2::dynamic_field::borrow_mut<FeeScheduleKey<T0>, FeeSchedule<T0>>(&mut arg0.id, fee_schedule_key<T0>()).price = arg1;
        };
    }

    public entry fun withdraw_fee_proceeds<T0>(arg0: &VenueAdminCap, arg1: &mut Venue, arg2: &mut 0x2::tx_context::TxContext) {
        withdraw_fee_proceeds_<T0>(arg1, arg2);
    }

    fun withdraw_fee_proceeds_<T0>(arg0: &mut Venue, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::dynamic_field::remove<FeeProceedsKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, fee_proceeds_key<T0>()), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

