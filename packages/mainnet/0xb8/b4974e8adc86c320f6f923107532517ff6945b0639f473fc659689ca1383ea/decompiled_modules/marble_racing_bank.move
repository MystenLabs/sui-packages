module 0xb8b4974e8adc86c320f6f923107532517ff6945b0639f473fc659689ca1383ea::marble_racing_bank {
    struct MarbleRacingBank<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<T0>,
    }

    struct BankCap has store, key {
        id: 0x2::object::UID,
        original_id_cap: 0x2::object::ID,
    }

    struct BankConfig has store, key {
        id: 0x2::object::UID,
        managers: 0x2::vec_set::VecSet<address>,
    }

    public(friend) fun add_manager(arg0: &mut BankConfig, arg1: &BankCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    fun assert_sender_is_manager(arg0: &BankConfig, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            abort 1
        };
    }

    public(friend) fun burn_admin_cap(arg0: BankCap) {
        let BankCap {
            id              : v0,
            original_id_cap : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun get_from_bank<T0>(arg0: &BankConfig, arg1: &mut MarbleRacingBank<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_sender_is_manager(arg0, arg3);
        0x2::balance::split<T0>(&mut arg1.pool, arg2)
    }

    public(friend) fun mint_child_admin_cap(arg0: &BankCap, arg1: &mut 0x2::tx_context::TxContext) : BankCap {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg0.original_id_cap, 0);
        BankCap{
            id              : 0x2::object::new(arg1),
            original_id_cap : 0x2::object::uid_to_inner(&arg0.id),
        }
    }

    public(friend) fun new_bank<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = BankCap{
            id              : v0,
            original_id_cap : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::public_transfer<BankCap>(v1, arg0);
        let v2 = BankConfig{
            id       : 0x2::object::new(arg1),
            managers : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<BankConfig>(v2);
        let v3 = MarbleRacingBank<T0>{
            id   : 0x2::object::new(arg1),
            pool : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<MarbleRacingBank<T0>>(v3);
    }

    public(friend) fun put_to_bank<T0>(arg0: &mut MarbleRacingBank<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.pool, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun remove_manager(arg0: &mut BankConfig, arg1: &BankCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public(friend) fun withdraw_from_bank<T0>(arg0: address, arg1: &BankConfig, arg2: &mut MarbleRacingBank<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.pool, 0x2::balance::value<T0>(&arg2.pool)), arg3), arg0);
    }

    // decompiled from Move bytecode v6
}

