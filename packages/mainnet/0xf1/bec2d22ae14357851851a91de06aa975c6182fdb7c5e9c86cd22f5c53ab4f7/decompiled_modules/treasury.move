module 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::treasury {
    struct VersionDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ExpansionPercentage has store {
        total_supply: u64,
        cap: u64,
    }

    struct Treasury has store, key {
        id: 0x2::object::UID,
        expansion_percentages: vector<ExpansionPercentage>,
        minted_cash_board_room_percentage: u64,
        treasurer: address,
        cash_minter_member: 0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Member<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>,
        bond_minter_member: 0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Member<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo_minter_role::PBO_MINTER_ROLE>,
        reserve_cash: 0x2::balance::Balance<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>,
        reserve_bond: 0x2::balance::Balance<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::PBO>,
        operators: 0x2::table::Table<address, bool>,
    }

    public entry fun allocate<T0, T1>(arg0: &mut Treasury, arg1: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::boardroom::Boardroom, arg2: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg3: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::Oracle<T0, T1>, arg4: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg5: &mut 0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::TreasuryManagement, arg6: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>, arg7: &mut 0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::TreasuryManagement, arg8: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo_minter_role::PBO_MINTER_ROLE>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert!(0x2::table::contains<address, bool>(&arg0.operators, 0x2::tx_context::sender(arg10)), 7);
        0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::check_epoch(arg2, arg9);
        0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::next(arg2);
        allocate_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun allocate_internal<T0, T1>(arg0: &mut Treasury, arg1: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::boardroom::Boardroom, arg2: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg3: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::Oracle<T0, T1>, arg4: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg5: &mut 0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::TreasuryManagement, arg6: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>, arg7: &mut 0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::TreasuryManagement, arg8: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo_minter_role::PBO_MINTER_ROLE>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        update_cash_price<T0, T1>(arg3, arg4, arg2, arg9);
        let v0 = get_cash_price<T0, T1>(arg3);
        let v1 = if (v0 > 1000000) {
            0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::state::expansion()
        } else {
            0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::state::contraction()
        };
        0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::set_state(arg2, v1);
        if (0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::state::is_expansion(v1)) {
            let v2 = 0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::total_supply(arg5);
            let v3 = get_expansion_percentage_cap(&arg0.expansion_percentages, v2);
            let v4 = (v0 - 1000000) * 1000000 / 1000000;
            let v5 = v4;
            if (v4 > v3) {
                v5 = v3;
            };
            if (unsafe_compute_cash_amount(0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::total_supply(arg7), v0) > 0x2::balance::value<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(&arg0.reserve_cash)) {
                v5 = v5 / 2;
            };
            if (v5 > 0) {
                let v6 = (((v2 as u256) * (v5 as u256) / (1000000 as u256)) as u64);
                let v7 = 0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::mint(arg5, arg6, &arg0.cash_minter_member, v6, arg10);
                0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::boardroom::allocate(arg1, 0x2::coin::split<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(&mut v7, (((v6 as u256) * (arg0.minted_cash_board_room_percentage as u256) / (1000000 as u256)) as u64), arg10), arg2, arg10);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>>(v7, arg0.treasurer);
            };
        } else {
            0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::boardroom::allocate(arg1, 0x2::coin::zero<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(arg10), arg2, arg10);
            let v8 = 0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::total_supply(arg5);
            0x2::balance::join<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::PBO>(&mut arg0.reserve_bond, 0x2::coin::into_balance<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::PBO>(0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::mint(arg7, arg8, &arg0.bond_minter_member, (((v8 as u256) * (get_expansion_percentage_cap(&arg0.expansion_percentages, v8) as u256) / (1000000 as u256)) as u64), arg10)));
        };
    }

    fun assert_version(arg0: &0x2::object::UID) {
        let v0 = VersionDfKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<VersionDfKey, u64>(arg0, v0) == 1, 999);
    }

    fun assert_version_and_upgrade(arg0: &mut Treasury) {
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(&mut arg0.id, v0);
        if (*v1 < 1) {
            *v1 = 1;
        };
        assert_version(&arg0.id);
    }

    public entry fun buy_bond(arg0: &mut Treasury, arg1: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg2: &mut 0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::TreasuryManagement, arg3: 0x2::coin::Coin<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert!(0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg1) > 0, 6);
        let v0 = 0x2::coin::value<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(&arg3);
        assert!(v0 > 0, 4);
        assert!(0x2::balance::value<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::PBO>(&arg0.reserve_bond) >= v0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::PBO>>(0x2::coin::from_balance<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::PBO>(0x2::balance::split<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::PBO>(&mut arg0.reserve_bond, v0), arg4), 0x2::tx_context::sender(arg4));
        0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::burn(arg2, arg3, arg4);
    }

    public(friend) fun create(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: address, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 3);
        assert!(arg2 <= 1000000, 1);
        let v0 = Treasury{
            id                                : 0x2::object::new(arg5),
            expansion_percentages             : 0x1::vector::empty<ExpansionPercentage>(),
            minted_cash_board_room_percentage : arg2,
            treasurer                         : arg3,
            cash_minter_member                : 0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::create_member<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>(arg5),
            bond_minter_member                : 0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::create_member<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo_minter_role::PBO_MINTER_ROLE>(arg5),
            reserve_cash                      : 0x2::balance::zero<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(),
            reserve_bond                      : 0x2::balance::zero<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::PBO>(),
            operators                         : 0x2::table::new<address, bool>(arg5),
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            assert!(v2 < 1000000, 1);
            let v3 = *0x1::vector::borrow<u64>(&arg0, v1);
            assert!(v3 > 0, 2);
            let v4 = ExpansionPercentage{
                total_supply : v3,
                cap          : v2,
            };
            0x1::vector::push_back<ExpansionPercentage>(&mut v0.expansion_percentages, v4);
            v1 = v1 + 1;
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(&arg4)) {
            0x2::table::add<address, bool>(&mut v0.operators, *0x1::vector::borrow<address>(&arg4, v5), true);
            v5 = v5 + 1;
        };
        let v6 = VersionDfKey{dummy_field: false};
        0x2::dynamic_field::add<VersionDfKey, u64>(&mut v0.id, v6, 1);
        0x2::transfer::share_object<Treasury>(v0);
    }

    public entry fun deposit(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.treasurer == 0x2::tx_context::sender(arg2), 8);
        0x2::balance::join<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(&mut arg0.reserve_cash, 0x2::coin::into_balance<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(arg1));
    }

    fun get_cash_price<T0, T1>(arg0: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::Oracle<T0, T1>) : u64 {
        if (0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::is_tracked_x<T0, T1>(arg0)) {
            0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::consult_x<T0, T1>(arg0, 0x2::math::pow(10, 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::tracked_coin_decimals<T0, T1>(arg0)))
        } else {
            0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::consult_y<T0, T1>(arg0, 0x2::math::pow(10, 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::tracked_coin_decimals<T0, T1>(arg0)))
        }
    }

    fun get_expansion_percentage_cap(arg0: &vector<ExpansionPercentage>, arg1: u64) : u64 {
        let v0 = 1;
        let v1 = 0x1::vector::borrow<ExpansionPercentage>(arg0, 0).cap;
        while (v0 < 0x1::vector::length<ExpansionPercentage>(arg0)) {
            let v2 = 0x1::vector::borrow<ExpansionPercentage>(arg0, v0);
            if (arg1 > v2.total_supply) {
                v1 = v2.cap;
            };
            v0 = v0 + 1;
        };
        v1
    }

    public entry fun grant_operator(arg0: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::admin_cap::AdminCap, arg1: &mut Treasury, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.operators, arg2, true);
    }

    public(friend) fun initial_allocate<T0, T1>(arg0: &mut Treasury, arg1: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::boardroom::Boardroom, arg2: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg3: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::Oracle<T0, T1>, arg4: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg5: &mut 0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::TreasuryManagement, arg6: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>, arg7: &mut 0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::TreasuryManagement, arg8: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo_minter_role::PBO_MINTER_ROLE>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        allocate_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun migrate(arg0: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::admin_cap::AdminCap, arg1: &mut Treasury) {
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(&mut arg1.id, v0);
        assert!(*v1 < 1, 1000);
        *v1 = 1;
    }

    fun min_u256(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0;
        if (arg1 < arg0) {
            v0 = arg1;
        };
        v0
    }

    public entry fun redeem_bond<T0, T1>(arg0: &mut Treasury, arg1: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg2: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::Oracle<T0, T1>, arg3: &mut 0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::TreasuryManagement, arg4: 0x2::coin::Coin<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::PBO>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert!(0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg1) > 0, 6);
        let v0 = 0x2::coin::value<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::PBO>(&arg4);
        assert!(v0 > 0, 4);
        assert!(0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::state::is_expansion(0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::state(arg1)), 6);
        let v1 = unsafe_compute_cash_amount(v0, 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::get_price_at<T0, T1>(arg2, 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg1)));
        assert!(0x2::balance::value<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(&arg0.reserve_cash) >= v1, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>>(0x2::coin::from_balance<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(0x2::balance::split<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(&mut arg0.reserve_cash, v1), arg5), 0x2::tx_context::sender(arg5));
        0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::burn(arg3, arg4, arg5);
    }

    public entry fun revoke_operator(arg0: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::admin_cap::AdminCap, arg1: &mut Treasury, arg2: address) {
        0x2::table::remove<address, bool>(&mut arg1.operators, arg2);
    }

    public entry fun set_treasurer(arg0: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::admin_cap::AdminCap, arg1: &mut Treasury, arg2: address) {
        arg1.treasurer = arg2;
    }

    fun unsafe_compute_cash_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u256) * ((1000000 as u256) + min_u256((300000 as u256), ((arg1 - 1000000) as u256) * (750000 as u256) / (1000000 as u256))) / (1000000 as u256)) as u64)
    }

    fun update_cash_price<T0, T1>(arg0: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::Oracle<T0, T1>, arg1: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg3: &0x2::clock::Clock) {
        0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::update<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.treasurer == v0, 8);
        assert!(0x2::balance::value<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(&arg0.reserve_cash) >= arg1, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>>(0x2::coin::from_balance<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(0x2::balance::split<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(&mut arg0.reserve_cash, arg1), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

