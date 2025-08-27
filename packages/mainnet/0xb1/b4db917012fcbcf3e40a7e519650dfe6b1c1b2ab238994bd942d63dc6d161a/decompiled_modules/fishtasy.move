module 0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::fishtasy {
    struct Fishtasy has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::option::Option<0x1::ascii::String>,
        box_prices: 0x2::vec_map::VecMap<u8, u64>,
        aquarium_upgrade_prices: vector<u64>,
    }

    struct Records has store, key {
        id: 0x2::object::UID,
        records: 0x2::table::Table<address, UserRecord>,
    }

    struct UserRecord has store {
        aquarium_level: u8,
        boxes: 0x2::vec_map::VecMap<u8, u64>,
    }

    struct PrimaryCoinAssigned has copy, drop {
        coin_type: 0x1::ascii::String,
    }

    struct BoxBoughtEvent has copy, drop {
        box_tier: u8,
        amount: u64,
        cost: u64,
        buyer: address,
        bought_at: u64,
    }

    struct BoxPricesChangedEvent has copy, drop {
        new_prices: vector<u64>,
    }

    struct AquariumUpgradePricesChangedEvent has copy, drop {
        new_prices: vector<u64>,
    }

    struct AquariumUpgradedEvent has copy, drop {
        previous_level: u8,
        current_level: u8,
        cost: u64,
    }

    struct AvoidedHalvingEvent has copy, drop {
        fish_number: u64,
        fish_id: 0x1::option::Option<0x1::string::String>,
        cost: u64,
    }

    struct TookRewardEvent<phantom T0> has copy, drop {
        reward_amount: u64,
        new_withdraw_pool_balance: u64,
    }

    struct RewardAddedEvent<phantom T0> has copy, drop {
        amount: u64,
        new_reward_pool_balance: u64,
    }

    struct ReserveAddedEvent<phantom T0> has copy, drop {
        amount: u64,
        new_reserve_pool_balance: u64,
    }

    struct ReserveSplitEvent<phantom T0> has copy, drop {
        amount: u64,
        new_reserve_pool_balance: u64,
    }

    struct RewardDistributedEvent<phantom T0> has copy, drop {
        amount: u64,
        new_reward_pool_balance: u64,
        new_reserve_pool_balance: u64,
    }

    struct WithdrawnEvent<phantom T0> has copy, drop {
        amount: u64,
        new_withdraw_pool_balance: u64,
    }

    public entry fun add_reserve<T0>(arg0: &mut Fishtasy, arg1: &0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::Configuration, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::check_package_version(arg1);
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::validate_admin(arg1, arg3);
        validate_coin_type<T0>(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"reserve_pool_balance"));
        0x2::balance::join<T0>(v0, 0x2::coin::into_balance<T0>(arg2));
        let v1 = ReserveAddedEvent<T0>{
            amount                   : 0x2::coin::value<T0>(&arg2),
            new_reserve_pool_balance : 0x2::balance::value<T0>(v0),
        };
        0x2::event::emit<ReserveAddedEvent<T0>>(v1);
    }

    public entry fun add_reward<T0>(arg0: &mut Fishtasy, arg1: &0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::Configuration, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::check_package_version(arg1);
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::validate_admin(arg1, arg3);
        validate_coin_type<T0>(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"reward_pool_balance"));
        0x2::balance::join<T0>(v0, 0x2::coin::into_balance<T0>(arg2));
        let v1 = RewardAddedEvent<T0>{
            amount                  : 0x2::coin::value<T0>(&arg2),
            new_reward_pool_balance : 0x2::balance::value<T0>(v0),
        };
        0x2::event::emit<RewardAddedEvent<T0>>(v1);
    }

    public entry fun assign_primary_coin<T0>(arg0: &mut Fishtasy, arg1: &0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::Configuration, arg2: &mut 0x2::tx_context::TxContext) {
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::check_package_version(arg1);
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::validate_admin(arg1, arg2);
        arg0.coin_type = 0x1::option::some<0x1::ascii::String>(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"reward_pool_balance"), 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"withdraw_pool_balance"), 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"reserve_pool_balance"), 0x2::balance::zero<T0>());
        let v0 = PrimaryCoinAssigned{coin_type: 0x1::type_name::into_string(0x1::type_name::get<T0>())};
        0x2::event::emit<PrimaryCoinAssigned>(v0);
    }

    public entry fun avoid_halving<T0>(arg0: &mut Fishtasy, arg1: &0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::Configuration, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::option::Option<0x1::string::String>, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::check_package_version(arg1);
        validate_coin_type<T0>(arg0);
        assert!(0x2::tx_context::sender(arg10) == arg6, 1012);
        assert!(0x2::coin::value<T0>(&arg2) >= arg5, 1003);
        assert!(0x2::clock::timestamp_ms(arg9) < arg7, 1006);
        if (arg4 == 1) {
            assert!(0x1::option::is_some<0x1::string::String>(&arg3), 1010);
        } else {
            assert!(arg4 > 0 && 0x1::option::is_none<0x1::string::String>(&arg3), 1011);
        };
        verify_avoid_halving_signature(0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::get_verifier_pubkey(arg1), arg4, arg5, arg6, arg7, arg8);
        distribute_reward<T0>(arg0, arg1, arg5, arg2, arg10);
        let v0 = AvoidedHalvingEvent{
            fish_number : arg4,
            fish_id     : arg3,
            cost        : arg5,
        };
        0x2::event::emit<AvoidedHalvingEvent>(v0);
    }

    public entry fun buy_box<T0>(arg0: &mut Fishtasy, arg1: &0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::Configuration, arg2: &mut Records, arg3: u8, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::check_package_version(arg1);
        validate_coin_type<T0>(arg0);
        let v0 = 0x2::vec_map::try_get<u8, u64>(&arg0.box_prices, &arg3);
        assert!(0x1::option::is_some<u64>(&v0), 1002);
        let v1 = *0x1::option::borrow<u64>(&v0) * arg4;
        assert!(0x2::coin::value<T0>(&arg5) >= v1, 1003);
        if (!0x2::table::contains<address, UserRecord>(&arg2.records, 0x2::tx_context::sender(arg7))) {
            let v2 = 0x2::vec_map::empty<u8, u64>();
            0x2::vec_map::insert<u8, u64>(&mut v2, arg3, arg4);
            let v3 = UserRecord{
                aquarium_level : 0,
                boxes          : v2,
            };
            0x2::table::add<address, UserRecord>(&mut arg2.records, 0x2::tx_context::sender(arg7), v3);
        } else {
            let v4 = 0x2::table::borrow_mut<address, UserRecord>(&mut arg2.records, 0x2::tx_context::sender(arg7));
            if (!0x2::vec_map::contains<u8, u64>(&v4.boxes, &arg3)) {
                0x2::vec_map::insert<u8, u64>(&mut v4.boxes, arg3, arg4);
            } else {
                let v5 = 0x2::vec_map::get_mut<u8, u64>(&mut v4.boxes, &arg3);
                *v5 = *v5 + arg4;
            };
        };
        distribute_reward<T0>(arg0, arg1, v1, arg5, arg7);
        let v6 = BoxBoughtEvent{
            box_tier  : arg3,
            amount    : arg4,
            cost      : v1,
            buyer     : 0x2::tx_context::sender(arg7),
            bought_at : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<BoxBoughtEvent>(v6);
    }

    public entry fun change_aquarium_upgrade_prices(arg0: &mut Fishtasy, arg1: &0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::Configuration, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::check_package_version(arg1);
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::validate_admin(arg1, arg3);
        assert!(0x1::vector::length<u64>(&arg2) > 0, 1004);
        arg0.aquarium_upgrade_prices = arg2;
        let v0 = AquariumUpgradePricesChangedEvent{new_prices: arg2};
        0x2::event::emit<AquariumUpgradePricesChangedEvent>(v0);
    }

    public entry fun change_box_prices(arg0: &mut Fishtasy, arg1: &0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::Configuration, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::check_package_version(arg1);
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::validate_admin(arg1, arg3);
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 > 0, 1004);
        let v1 = 0x2::vec_map::empty<u8, u64>();
        let v2 = 0;
        while (v2 < v0) {
            0x2::vec_map::insert<u8, u64>(&mut v1, (v2 as u8), *0x1::vector::borrow<u64>(&arg2, v2));
            v2 = v2 + 1;
        };
        arg0.box_prices = v1;
        let v3 = BoxPricesChangedEvent{new_prices: arg2};
        0x2::event::emit<BoxPricesChangedEvent>(v3);
    }

    public entry fun distribute_reserve<T0>(arg0: &mut Fishtasy, arg1: &0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::Configuration, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::check_package_version(arg1);
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::validate_admin(arg1, arg3);
        validate_coin_type<T0>(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"reserve_pool_balance"));
        assert!(0x2::balance::value<T0>(v0) >= arg2, 1014);
        let v1 = 0x2::balance::split<T0>(v0, arg2);
        let v2 = 0x2::balance::value<T0>(v0);
        let v3 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"reward_pool_balance"));
        0x2::balance::join<T0>(v3, v1);
        let v4 = RewardDistributedEvent<T0>{
            amount                   : arg2,
            new_reward_pool_balance  : 0x2::balance::value<T0>(v3),
            new_reserve_pool_balance : v2,
        };
        0x2::event::emit<RewardDistributedEvent<T0>>(v4);
    }

    fun distribute_reward<T0>(arg0: &mut Fishtasy, arg1: &0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::Configuration, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) >= arg2, 1003);
        let v0 = arg2 * 2 / 10;
        let v1 = (arg2 - v0) * 85 / 100;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"reward_pool_balance")), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v1, arg4)));
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"reserve_pool_balance")), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, arg2 - v0 - v1, arg4)));
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::utils::send_coin<T0>(0x2::coin::split<T0>(&mut arg3, v0, arg4), 0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::get_admin(arg1));
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Records{
            id      : 0x2::object::new(arg0),
            records : 0x2::table::new<address, UserRecord>(arg0),
        };
        let v1 = Fishtasy{
            id                      : 0x2::object::new(arg0),
            coin_type               : 0x1::option::none<0x1::ascii::String>(),
            box_prices              : init_box_prices(),
            aquarium_upgrade_prices : init_aquarium_upgrade_prices(),
        };
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::new_configuration_and_shared(arg0);
        0x2::transfer::public_share_object<Fishtasy>(v1);
        0x2::transfer::public_share_object<Records>(v0);
    }

    fun init_aquarium_upgrade_prices() : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 500000000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000000000);
        0x1::vector::push_back<u64>(&mut v0, 1500000000000);
        0x1::vector::push_back<u64>(&mut v0, 2000000000000);
        0x1::vector::push_back<u64>(&mut v0, 2800000000000);
        0x1::vector::push_back<u64>(&mut v0, 5000000000000);
        0x1::vector::push_back<u64>(&mut v0, 8000000000000);
        v0
    }

    fun init_box_prices() : 0x2::vec_map::VecMap<u8, u64> {
        let v0 = 0x2::vec_map::empty<u8, u64>();
        0x2::vec_map::insert<u8, u64>(&mut v0, 1, 100000000000);
        0x2::vec_map::insert<u8, u64>(&mut v0, 2, 200000000000);
        v0
    }

    public entry fun split_reserve<T0>(arg0: &mut Fishtasy, arg1: &0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::Configuration, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::check_package_version(arg1);
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::validate_admin(arg1, arg3);
        validate_coin_type<T0>(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"reserve_pool_balance"));
        assert!(0x2::balance::value<T0>(v0) >= arg2, 1014);
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg2), arg3), 0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::get_admin(arg1));
        let v1 = ReserveSplitEvent<T0>{
            amount                   : arg2,
            new_reserve_pool_balance : 0x2::balance::value<T0>(v0),
        };
        0x2::event::emit<ReserveSplitEvent<T0>>(v1);
    }

    public entry fun take_reward<T0>(arg0: &mut Fishtasy, arg1: &0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::Configuration, arg2: &mut 0x2::tx_context::TxContext) {
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::check_package_version(arg1);
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::validate_admin(arg1, arg2);
        validate_coin_type<T0>(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"reward_pool_balance"));
        assert!(0x2::balance::value<T0>(v0) > 0, 1013);
        let v1 = 0x2::balance::split<T0>(v0, 0x2::balance::value<T0>(v0) / 30);
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"withdraw_pool_balance"));
        0x2::balance::join<T0>(v2, v1);
        let v3 = TookRewardEvent<T0>{
            reward_amount             : 0x2::balance::value<T0>(&v1),
            new_withdraw_pool_balance : 0x2::balance::value<T0>(v2),
        };
        0x2::event::emit<TookRewardEvent<T0>>(v3);
    }

    public entry fun upgrade_aquarium<T0>(arg0: &mut Fishtasy, arg1: &0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::Configuration, arg2: &mut Records, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::check_package_version(arg1);
        validate_coin_type<T0>(arg0);
        let (v0, v1, v2) = if (!0x2::table::contains<address, UserRecord>(&arg2.records, 0x2::tx_context::sender(arg4))) {
            let v3 = UserRecord{
                aquarium_level : 2,
                boxes          : 0x2::vec_map::empty<u8, u64>(),
            };
            0x2::table::add<address, UserRecord>(&mut arg2.records, 0x2::tx_context::sender(arg4), v3);
            let v2 = *0x1::vector::borrow<u64>(&arg0.aquarium_upgrade_prices, 0);
            (1, 2, v2)
        } else {
            let v4 = 0x2::table::borrow_mut<address, UserRecord>(&mut arg2.records, 0x2::tx_context::sender(arg4));
            let v5 = v4.aquarium_level;
            assert!(v5 < ((0x1::vector::length<u64>(&arg0.aquarium_upgrade_prices) + 1) as u8), 1009);
            let v6 = v5 + 1;
            v4.aquarium_level = v6;
            let v2 = *0x1::vector::borrow<u64>(&arg0.aquarium_upgrade_prices, ((v5 - 1) as u64));
            (v5, v6, v2)
        };
        distribute_reward<T0>(arg0, arg1, v2, arg3, arg4);
        let v7 = AquariumUpgradedEvent{
            previous_level : v0,
            current_level  : v1,
            cost           : v2,
        };
        0x2::event::emit<AquariumUpgradedEvent>(v7);
    }

    fun validate_coin_type<T0>(arg0: &Fishtasy) {
        assert!(0x1::option::is_some<0x1::ascii::String>(&arg0.coin_type), 1000);
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == *0x1::option::borrow<0x1::ascii::String>(&arg0.coin_type), 1001);
    }

    fun verify_avoid_halving_signature(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: vector<u8>) {
        let v0 = b"FISHTASY";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0, &v0), 1005);
    }

    fun verify_withdraw_signature(arg0: vector<u8>, arg1: u64, arg2: address, arg3: u64, arg4: vector<u8>) {
        let v0 = b"FISHTASY";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0, &v0), 1005);
    }

    public entry fun withdraw<T0>(arg0: &mut Fishtasy, arg1: &0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::Configuration, arg2: u64, arg3: address, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::check_package_version(arg1);
        validate_coin_type<T0>(arg0);
        assert!(0x2::tx_context::sender(arg7) == arg3, 1012);
        assert!(0x2::clock::timestamp_ms(arg6) < arg4, 1006);
        verify_withdraw_signature(0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration::get_verifier_pubkey(arg1), arg2, arg3, arg4, arg5);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"withdraw_pool_balance"));
        assert!(0x2::balance::value<T0>(v0) >= arg2, 1014);
        0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg2), arg7), arg3);
        let v1 = WithdrawnEvent<T0>{
            amount                    : arg2,
            new_withdraw_pool_balance : 0x2::balance::value<T0>(v0),
        };
        0x2::event::emit<WithdrawnEvent<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

