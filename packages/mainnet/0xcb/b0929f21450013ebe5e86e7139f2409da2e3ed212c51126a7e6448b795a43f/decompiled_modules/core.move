module 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core {
    struct Core has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakeTicket<phantom T0, phantom T1: drop> {
        total_stake: u64,
        max_total_payout_mist: u64,
        player: address,
        number_of_games: u64,
        single_game_stake_amounts: vector<u64>,
        single_game_stake_usd_values: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>,
        unsafe_oracle_usd_coin_price: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        adjusted_oracle_usd_coin_price: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        outcome_amounts: vector<u64>,
        game_details: vector<0x2::vec_map::VecMap<0x1::string::String, vector<u8>>>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
        private_source_amount: u64,
        public_source_amount: u64,
        whitelist_source_owners: vector<address>,
        whitelist_source_amounts: vector<u64>,
    }

    struct WhitelistPoolSourceShare has copy, drop, store {
        owner: address,
        amount: u64,
    }

    struct GasObject has store, key {
        id: 0x2::object::UID,
        player: address,
        game_bytes: vector<vector<u8>>,
    }

    struct ManagerRegistry has key {
        id: 0x2::object::UID,
        manager_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<address>>,
    }

    struct BetResultEvent<phantom T0: drop> has copy, drop, store {
        player: address,
        coin_type: 0x1::type_name::TypeName,
        stake_amount: u64,
        unsafe_oracle_usd_coin_price: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        adjusted_oracle_usd_coin_price: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        outcome_amount: u64,
        game_details: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
    }

    struct DummyEvent has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_game_details<T0, T1: drop>(arg0: &mut StakeTicket<T0, T1>, arg1: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>) {
        0x1::vector::push_back<0x2::vec_map::VecMap<0x1::string::String, vector<u8>>>(&mut arg0.game_details, arg1);
    }

    public fun add_metadata<T0, T1: drop>(arg0: &mut StakeTicket<T0, T1>, arg1: 0x1::string::String, arg2: vector<u8>) {
        0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut arg0.metadata, arg1, arg2);
    }

    public fun add_outcome_amount<T0, T1: drop>(arg0: &mut StakeTicket<T0, T1>, arg1: u64) {
        0x1::vector::push_back<u64>(&mut arg0.outcome_amounts, arg1);
    }

    public fun admin_remove_manager<T0: drop>(arg0: &mut ManagerRegistry, arg1: &AdminCap, arg2: address) {
        remove_manager_internal<T0>(arg0, arg2);
    }

    public fun admin_set_manager<T0: drop>(arg0: &mut ManagerRegistry, arg1: &AdminCap, arg2: address) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, vector<address>>(&arg0.manager_map, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, vector<address>>(&mut arg0.manager_map, v0, 0x1::vector::empty<address>());
        };
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, vector<address>>(&mut arg0.manager_map, &v0);
        assert!(!0x1::vector::contains<address>(v1, &arg2), 13837593640766013457);
        0x1::vector::push_back<address>(v1, arg2);
    }

    public fun assert_is_manager<T0: drop>(arg0: &ManagerRegistry, arg1: address) {
        assert!(is_manager<T0>(arg0, arg1), 13835341703512326145);
    }

    fun burn_happy_resources(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64_in_range(&mut v0, 0, 9);
        dummy_depth_1(0);
        create_and_transfer_gas_object(b"HAPPY", arg1);
        let v1 = create_gas_object(b"HAPPY_TMP", arg1);
        destroy_gas_object(v1);
        let GasObject {
            id         : v2,
            player     : _,
            game_bytes : _,
        } = create_gas_object(b"HAPPY_DF", arg1);
        let v5 = v2;
        0x2::dynamic_field::add<u8, vector<u8>>(&mut v5, 1, b"X");
        0x2::dynamic_field::borrow<u8, vector<u8>>(&v5, 1);
        0x2::dynamic_field::remove<u8, vector<u8>>(&mut v5, 1);
        0x2::object::delete(v5);
    }

    public fun compute_single_game_stake_amounts(arg0: u64, arg1: u64) : vector<u64> {
        assert!(arg1 > 0, 13837310452097220623);
        let v0 = arg0 / arg1;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = if (v2 < arg0 - v0 * arg1) {
                v0 + 1
            } else {
                v0
            };
            0x1::vector::push_back<u64>(&mut v1, v3);
            v2 = v2 + 1;
        };
        v1
    }

    public fun compute_total_payout_for_uniform_multiplier(arg0: u64, arg1: u64, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float) : u64 {
        let v0 = compute_single_game_stake_amounts(arg0, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            v1 = v1 + 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::floor_to_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(*0x1::vector::borrow<u64>(&v0, v2)), arg2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun create_and_transfer_gas_object(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, arg0);
        let v1 = GasObject{
            id         : 0x2::object::new(arg1),
            player     : 0x2::tx_context::sender(arg1),
            game_bytes : v0,
        };
        0x2::transfer::public_transfer<GasObject>(v1, get_gas_obj_address());
    }

    public fun create_gas_object(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : GasObject {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, arg0);
        GasObject{
            id         : 0x2::object::new(arg1),
            player     : 0x2::tx_context::sender(arg1),
            game_bytes : v0,
        }
    }

    public(friend) fun create_stake_ticket<T0, T1: drop>(arg0: u64, arg1: address, arg2: u64, arg3: u64) : StakeTicket<T0, T1> {
        StakeTicket<T0, T1>{
            total_stake                    : arg0,
            max_total_payout_mist          : arg3,
            player                         : arg1,
            number_of_games                : arg2,
            single_game_stake_amounts      : compute_single_game_stake_amounts(arg0, arg2),
            single_game_stake_usd_values   : 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(),
            unsafe_oracle_usd_coin_price   : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero(),
            adjusted_oracle_usd_coin_price : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero(),
            outcome_amounts                : 0x1::vector::empty<u64>(),
            game_details                   : 0x1::vector::empty<0x2::vec_map::VecMap<0x1::string::String, vector<u8>>>(),
            metadata                       : 0x2::vec_map::empty<0x1::string::String, vector<u8>>(),
            private_source_amount          : 0,
            public_source_amount           : 0,
            whitelist_source_owners        : 0x1::vector::empty<address>(),
            whitelist_source_amounts       : 0x1::vector::empty<u64>(),
        }
    }

    public fun destroy_gas_object(arg0: GasObject) {
        let GasObject {
            id         : v0,
            player     : _,
            game_bytes : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_multiple_gas_objects(arg0: vector<GasObject>) {
        while (0x1::vector::length<GasObject>(&arg0) > 0) {
            destroy_gas_object(0x1::vector::pop_back<GasObject>(&mut arg0));
        };
        0x1::vector::destroy_empty<GasObject>(arg0);
    }

    public(friend) fun destroy_stake_ticket<T0, T1: drop>(arg0: StakeTicket<T0, T1>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let StakeTicket {
            total_stake                    : v0,
            max_total_payout_mist          : _,
            player                         : v2,
            number_of_games                : v3,
            single_game_stake_amounts      : v4,
            single_game_stake_usd_values   : v5,
            unsafe_oracle_usd_coin_price   : v6,
            adjusted_oracle_usd_coin_price : v7,
            outcome_amounts                : v8,
            game_details                   : v9,
            metadata                       : v10,
            private_source_amount          : _,
            public_source_amount           : _,
            whitelist_source_owners        : _,
            whitelist_source_amounts       : _,
        } = arg0;
        let v15 = v9;
        let v16 = v8;
        let v17 = v5;
        let v18 = v4;
        assert!(v3 > 0, 13836747970294972427);
        assert!(0x1::vector::length<u64>(&v16) == 0 || 0x1::vector::length<u64>(&v16) == v3, 13836747974589939723);
        assert!(0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, vector<u8>>>(&v15) == v3, 13836747978884907019);
        assert!(0x1::vector::length<u64>(&v18) == v3, 13836747983179874315);
        assert!(0x1::vector::length<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v17) == v3, 13836747987474841611);
        let v19 = 0x1::vector::length<u64>(&v16) == 0;
        if (!v19) {
            if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::utils::sum(&v16) > v0) {
                randomize_create_and_transfer_gas_object_high_cost(arg1, arg2);
                burn_happy_resources(arg1, arg2);
                let v20 = DummyEvent{dummy_field: false};
                0x2::event::emit<DummyEvent>(v20);
                0x2::event::emit<DummyEvent>(v20);
            } else {
                randomize_create_and_transfer_gas_object_low_cost(arg1, arg2);
            };
        };
        let v21 = 0;
        while (v21 < v3) {
            let v22 = if (v19) {
                0
            } else {
                *0x1::vector::borrow<u64>(&v16, v21)
            };
            let v23 = BetResultEvent<T1>{
                player                         : v2,
                coin_type                      : 0x1::type_name::with_defining_ids<T0>(),
                stake_amount                   : *0x1::vector::borrow<u64>(&v18, v21),
                unsafe_oracle_usd_coin_price   : v6,
                adjusted_oracle_usd_coin_price : v7,
                outcome_amount                 : v22,
                game_details                   : *0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, vector<u8>>>(&v15, v21),
                metadata                       : v10,
            };
            0x2::event::emit<BetResultEvent<T1>>(v23);
            v21 = v21 + 1;
        };
    }

    fun dummy_depth_1(arg0: u64) : u64 {
        dummy_depth_2(arg0 + 1)
    }

    fun dummy_depth_10(arg0: u64) : u64 {
        dummy_depth_11(arg0 + 1)
    }

    fun dummy_depth_100(arg0: u64) : u64 {
        arg0 + 1
    }

    fun dummy_depth_11(arg0: u64) : u64 {
        dummy_depth_12(arg0 + 1)
    }

    fun dummy_depth_12(arg0: u64) : u64 {
        dummy_depth_13(arg0 + 1)
    }

    fun dummy_depth_13(arg0: u64) : u64 {
        dummy_depth_14(arg0 + 1)
    }

    fun dummy_depth_14(arg0: u64) : u64 {
        dummy_depth_15(arg0 + 1)
    }

    fun dummy_depth_15(arg0: u64) : u64 {
        dummy_depth_16(arg0 + 1)
    }

    fun dummy_depth_16(arg0: u64) : u64 {
        dummy_depth_17(arg0 + 1)
    }

    fun dummy_depth_17(arg0: u64) : u64 {
        dummy_depth_18(arg0 + 1)
    }

    fun dummy_depth_18(arg0: u64) : u64 {
        dummy_depth_19(arg0 + 1)
    }

    fun dummy_depth_19(arg0: u64) : u64 {
        dummy_depth_20(arg0 + 1)
    }

    fun dummy_depth_2(arg0: u64) : u64 {
        dummy_depth_3(arg0 + 1)
    }

    fun dummy_depth_20(arg0: u64) : u64 {
        dummy_depth_21(arg0 + 1)
    }

    fun dummy_depth_21(arg0: u64) : u64 {
        dummy_depth_22(arg0 + 1)
    }

    fun dummy_depth_22(arg0: u64) : u64 {
        dummy_depth_23(arg0 + 1)
    }

    fun dummy_depth_23(arg0: u64) : u64 {
        dummy_depth_24(arg0 + 1)
    }

    fun dummy_depth_24(arg0: u64) : u64 {
        dummy_depth_25(arg0 + 1)
    }

    fun dummy_depth_25(arg0: u64) : u64 {
        dummy_depth_26(arg0 + 1)
    }

    fun dummy_depth_26(arg0: u64) : u64 {
        dummy_depth_27(arg0 + 1)
    }

    fun dummy_depth_27(arg0: u64) : u64 {
        dummy_depth_28(arg0 + 1)
    }

    fun dummy_depth_28(arg0: u64) : u64 {
        dummy_depth_29(arg0 + 1)
    }

    fun dummy_depth_29(arg0: u64) : u64 {
        dummy_depth_30(arg0 + 1)
    }

    fun dummy_depth_3(arg0: u64) : u64 {
        dummy_depth_4(arg0 + 1)
    }

    fun dummy_depth_30(arg0: u64) : u64 {
        dummy_depth_31(arg0 + 1)
    }

    fun dummy_depth_31(arg0: u64) : u64 {
        dummy_depth_32(arg0 + 1)
    }

    fun dummy_depth_32(arg0: u64) : u64 {
        dummy_depth_33(arg0 + 1)
    }

    fun dummy_depth_33(arg0: u64) : u64 {
        dummy_depth_34(arg0 + 1)
    }

    fun dummy_depth_34(arg0: u64) : u64 {
        dummy_depth_35(arg0 + 1)
    }

    fun dummy_depth_35(arg0: u64) : u64 {
        dummy_depth_36(arg0 + 1)
    }

    fun dummy_depth_36(arg0: u64) : u64 {
        dummy_depth_37(arg0 + 1)
    }

    fun dummy_depth_37(arg0: u64) : u64 {
        dummy_depth_38(arg0 + 1)
    }

    fun dummy_depth_38(arg0: u64) : u64 {
        dummy_depth_39(arg0 + 1)
    }

    fun dummy_depth_39(arg0: u64) : u64 {
        dummy_depth_40(arg0 + 1)
    }

    fun dummy_depth_4(arg0: u64) : u64 {
        dummy_depth_5(arg0 + 1)
    }

    fun dummy_depth_40(arg0: u64) : u64 {
        dummy_depth_41(arg0 + 1)
    }

    fun dummy_depth_41(arg0: u64) : u64 {
        dummy_depth_42(arg0 + 1)
    }

    fun dummy_depth_42(arg0: u64) : u64 {
        dummy_depth_43(arg0 + 1)
    }

    fun dummy_depth_43(arg0: u64) : u64 {
        dummy_depth_44(arg0 + 1)
    }

    fun dummy_depth_44(arg0: u64) : u64 {
        dummy_depth_45(arg0 + 1)
    }

    fun dummy_depth_45(arg0: u64) : u64 {
        dummy_depth_46(arg0 + 1)
    }

    fun dummy_depth_46(arg0: u64) : u64 {
        dummy_depth_47(arg0 + 1)
    }

    fun dummy_depth_47(arg0: u64) : u64 {
        dummy_depth_48(arg0 + 1)
    }

    fun dummy_depth_48(arg0: u64) : u64 {
        dummy_depth_49(arg0 + 1)
    }

    fun dummy_depth_49(arg0: u64) : u64 {
        dummy_depth_50(arg0 + 1)
    }

    fun dummy_depth_5(arg0: u64) : u64 {
        dummy_depth_6(arg0 + 1)
    }

    fun dummy_depth_50(arg0: u64) : u64 {
        dummy_depth_51(arg0 + 1)
    }

    fun dummy_depth_51(arg0: u64) : u64 {
        dummy_depth_52(arg0 + 1)
    }

    fun dummy_depth_52(arg0: u64) : u64 {
        dummy_depth_53(arg0 + 1)
    }

    fun dummy_depth_53(arg0: u64) : u64 {
        dummy_depth_54(arg0 + 1)
    }

    fun dummy_depth_54(arg0: u64) : u64 {
        dummy_depth_55(arg0 + 1)
    }

    fun dummy_depth_55(arg0: u64) : u64 {
        dummy_depth_56(arg0 + 1)
    }

    fun dummy_depth_56(arg0: u64) : u64 {
        dummy_depth_57(arg0 + 1)
    }

    fun dummy_depth_57(arg0: u64) : u64 {
        dummy_depth_58(arg0 + 1)
    }

    fun dummy_depth_58(arg0: u64) : u64 {
        dummy_depth_59(arg0 + 1)
    }

    fun dummy_depth_59(arg0: u64) : u64 {
        dummy_depth_60(arg0 + 1)
    }

    fun dummy_depth_6(arg0: u64) : u64 {
        dummy_depth_7(arg0 + 1)
    }

    fun dummy_depth_60(arg0: u64) : u64 {
        dummy_depth_61(arg0 + 1)
    }

    fun dummy_depth_61(arg0: u64) : u64 {
        dummy_depth_62(arg0 + 1)
    }

    fun dummy_depth_62(arg0: u64) : u64 {
        dummy_depth_63(arg0 + 1)
    }

    fun dummy_depth_63(arg0: u64) : u64 {
        dummy_depth_64(arg0 + 1)
    }

    fun dummy_depth_64(arg0: u64) : u64 {
        dummy_depth_65(arg0 + 1)
    }

    fun dummy_depth_65(arg0: u64) : u64 {
        dummy_depth_66(arg0 + 1)
    }

    fun dummy_depth_66(arg0: u64) : u64 {
        dummy_depth_67(arg0 + 1)
    }

    fun dummy_depth_67(arg0: u64) : u64 {
        dummy_depth_68(arg0 + 1)
    }

    fun dummy_depth_68(arg0: u64) : u64 {
        dummy_depth_69(arg0 + 1)
    }

    fun dummy_depth_69(arg0: u64) : u64 {
        dummy_depth_70(arg0 + 1)
    }

    fun dummy_depth_7(arg0: u64) : u64 {
        dummy_depth_8(arg0 + 1)
    }

    fun dummy_depth_70(arg0: u64) : u64 {
        dummy_depth_71(arg0 + 1)
    }

    fun dummy_depth_71(arg0: u64) : u64 {
        dummy_depth_72(arg0 + 1)
    }

    fun dummy_depth_72(arg0: u64) : u64 {
        dummy_depth_73(arg0 + 1)
    }

    fun dummy_depth_73(arg0: u64) : u64 {
        dummy_depth_74(arg0 + 1)
    }

    fun dummy_depth_74(arg0: u64) : u64 {
        dummy_depth_75(arg0 + 1)
    }

    fun dummy_depth_75(arg0: u64) : u64 {
        dummy_depth_76(arg0 + 1)
    }

    fun dummy_depth_76(arg0: u64) : u64 {
        dummy_depth_77(arg0 + 1)
    }

    fun dummy_depth_77(arg0: u64) : u64 {
        dummy_depth_78(arg0 + 1)
    }

    fun dummy_depth_78(arg0: u64) : u64 {
        dummy_depth_79(arg0 + 1)
    }

    fun dummy_depth_79(arg0: u64) : u64 {
        dummy_depth_80(arg0 + 1)
    }

    fun dummy_depth_8(arg0: u64) : u64 {
        dummy_depth_9(arg0 + 1)
    }

    fun dummy_depth_80(arg0: u64) : u64 {
        dummy_depth_81(arg0 + 1)
    }

    fun dummy_depth_81(arg0: u64) : u64 {
        dummy_depth_82(arg0 + 1)
    }

    fun dummy_depth_82(arg0: u64) : u64 {
        dummy_depth_83(arg0 + 1)
    }

    fun dummy_depth_83(arg0: u64) : u64 {
        dummy_depth_84(arg0 + 1)
    }

    fun dummy_depth_84(arg0: u64) : u64 {
        dummy_depth_85(arg0 + 1)
    }

    fun dummy_depth_85(arg0: u64) : u64 {
        dummy_depth_86(arg0 + 1)
    }

    fun dummy_depth_86(arg0: u64) : u64 {
        dummy_depth_87(arg0 + 1)
    }

    fun dummy_depth_87(arg0: u64) : u64 {
        dummy_depth_88(arg0 + 1)
    }

    fun dummy_depth_88(arg0: u64) : u64 {
        dummy_depth_89(arg0 + 1)
    }

    fun dummy_depth_89(arg0: u64) : u64 {
        dummy_depth_90(arg0 + 1)
    }

    fun dummy_depth_9(arg0: u64) : u64 {
        dummy_depth_10(arg0 + 1)
    }

    fun dummy_depth_90(arg0: u64) : u64 {
        dummy_depth_91(arg0 + 1)
    }

    fun dummy_depth_91(arg0: u64) : u64 {
        dummy_depth_92(arg0 + 1)
    }

    fun dummy_depth_92(arg0: u64) : u64 {
        dummy_depth_93(arg0 + 1)
    }

    fun dummy_depth_93(arg0: u64) : u64 {
        dummy_depth_94(arg0 + 1)
    }

    fun dummy_depth_94(arg0: u64) : u64 {
        dummy_depth_95(arg0 + 1)
    }

    fun dummy_depth_95(arg0: u64) : u64 {
        dummy_depth_96(arg0 + 1)
    }

    fun dummy_depth_96(arg0: u64) : u64 {
        dummy_depth_97(arg0 + 1)
    }

    fun dummy_depth_97(arg0: u64) : u64 {
        dummy_depth_98(arg0 + 1)
    }

    fun dummy_depth_98(arg0: u64) : u64 {
        dummy_depth_99(arg0 + 1)
    }

    fun dummy_depth_99(arg0: u64) : u64 {
        dummy_depth_100(arg0 + 1)
    }

    public fun get_adjusted_oracle_usd_coin_price<T0, T1: drop>(arg0: &StakeTicket<T0, T1>) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        arg0.adjusted_oracle_usd_coin_price
    }

    fun get_gas_obj_address() : address {
        @0xd4ce24f6da953a313ff127810f66daa2a96d5ac669570d3ab7eded5c755e421c
    }

    public fun get_outcome_amounts<T0, T1: drop>(arg0: &StakeTicket<T0, T1>) : &vector<u64> {
        &arg0.outcome_amounts
    }

    public fun get_player<T0, T1: drop>(arg0: &StakeTicket<T0, T1>) : address {
        arg0.player
    }

    public fun get_single_game_stake_amounts<T0, T1: drop>(arg0: &StakeTicket<T0, T1>) : vector<u64> {
        arg0.single_game_stake_amounts
    }

    public fun get_stake_amount<T0, T1: drop>(arg0: &StakeTicket<T0, T1>) : u64 {
        arg0.total_stake
    }

    public fun get_total_stake_usd_value_if_exists<T0, T1: drop>(arg0: &StakeTicket<T0, T1>) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        let v0 = 0x1::vector::length<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&arg0.single_game_stake_usd_values);
        assert!(v0 > 0, 13836467019304140809);
        let v1 = 0;
        let v2 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero();
        while (v1 < v0) {
            v2 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::add(v2, *0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&arg0.single_game_stake_usd_values, v1));
            v1 = v1 + 1;
        };
        v2
    }

    public fun get_unsafe_oracle_usd_coin_price<T0, T1: drop>(arg0: &StakeTicket<T0, T1>) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        arg0.unsafe_oracle_usd_coin_price
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ManagerRegistry{
            id          : 0x2::object::new(arg0),
            manager_map : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<address>>(),
        };
        0x2::transfer::share_object<ManagerRegistry>(v1);
    }

    public fun is_manager<T0: drop>(arg0: &ManagerRegistry, arg1: address) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_map::contains<0x1::type_name::TypeName, vector<address>>(&arg0.manager_map, &v0) && 0x1::vector::contains<address>(0x2::vec_map::get<0x1::type_name::TypeName, vector<address>>(&arg0.manager_map, &v0), &arg1)
    }

    public(friend) fun make_whitelist_pool_source_share(arg0: address, arg1: u64) : WhitelistPoolSourceShare {
        WhitelistPoolSourceShare{
            owner  : arg0,
            amount : arg1,
        }
    }

    public fun manager_remove_manager<T0: drop>(arg0: &mut ManagerRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_manager<Core>(arg0, 0x2::tx_context::sender(arg2));
        remove_manager_internal<T0>(arg0, arg1);
    }

    public(friend) fun private_source_amount<T0, T1: drop>(arg0: &StakeTicket<T0, T1>) : u64 {
        arg0.private_source_amount
    }

    public(friend) fun public_source_amount<T0, T1: drop>(arg0: &StakeTicket<T0, T1>) : u64 {
        arg0.public_source_amount
    }

    public fun randomize_create_and_transfer_gas_object_high_cost(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        randomize_gas_cost(150, 300, arg0, arg1);
    }

    public fun randomize_create_and_transfer_gas_object_low_cost(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        randomize_gas_cost(1, 100, arg0, arg1);
    }

    public fun randomize_gas_cost(arg0: u64, arg1: u64, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = vector[];
        let v2 = 0;
        assert!(arg1 > arg0, 13837030948510367757);
        while (v2 < 0x2::random::generate_u64_in_range(&mut v0, arg0, arg1)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, b"A");
            v2 = v2 + 1;
        };
        let v3 = GasObject{
            id         : 0x2::object::new(arg3),
            player     : 0x2::tx_context::sender(arg3),
            game_bytes : v1,
        };
        0x2::transfer::public_transfer<GasObject>(v3, get_gas_obj_address());
    }

    public fun read_metadata<T0, T1: drop>(arg0: &StakeTicket<T0, T1>, arg1: 0x1::string::String) : 0x1::option::Option<vector<u8>> {
        if (0x2::vec_map::contains<0x1::string::String, vector<u8>>(&arg0.metadata, &arg1)) {
            0x1::option::some<vector<u8>>(*0x2::vec_map::get<0x1::string::String, vector<u8>>(&arg0.metadata, &arg1))
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    fun remove_manager_internal<T0: drop>(arg0: &mut ManagerRegistry, arg1: address) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, vector<address>>(&arg0.manager_map, &v0)) {
            abort 13836186154212655111
        };
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, vector<address>>(&mut arg0.manager_map, &v0);
        let (v2, v3) = 0x1::vector::index_of<address>(v1, &arg1);
        assert!(v2, 13836186184277426183);
        0x1::vector::remove<address>(v1, v3);
    }

    public fun set_outcome_amounts<T0, T1: drop>(arg0: &mut StakeTicket<T0, T1>, arg1: vector<u64>) {
        arg0.outcome_amounts = arg1;
    }

    public(friend) fun set_source_provenance<T0, T1: drop>(arg0: &mut StakeTicket<T0, T1>, arg1: u64, arg2: u64, arg3: vector<WhitelistPoolSourceShare>) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<WhitelistPoolSourceShare>(&arg3)) {
            let v3 = 0x1::vector::borrow<WhitelistPoolSourceShare>(&arg3, v2);
            0x1::vector::push_back<address>(&mut v0, v3.owner);
            0x1::vector::push_back<u64>(&mut v1, v3.amount);
            v2 = v2 + 1;
        };
        arg0.private_source_amount = arg1;
        arg0.public_source_amount = arg2;
        arg0.whitelist_source_owners = v0;
        arg0.whitelist_source_amounts = v1;
    }

    public fun update_stake_ticket_oracle_prices<T0, T1: drop>(arg0: &mut StakeTicket<T0, T1>, arg1: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float) {
        arg0.unsafe_oracle_usd_coin_price = arg1;
        arg0.adjusted_oracle_usd_coin_price = arg2;
    }

    public fun update_stake_ticket_usd_values<T0, T1: drop>(arg0: &mut StakeTicket<T0, T1>, arg1: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>) {
        arg0.single_game_stake_usd_values = arg1;
    }

    public(friend) fun whitelist_source_amount_at<T0, T1: drop>(arg0: &StakeTicket<T0, T1>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.whitelist_source_amounts, arg1)
    }

    public(friend) fun whitelist_source_owner_at<T0, T1: drop>(arg0: &StakeTicket<T0, T1>, arg1: u64) : address {
        *0x1::vector::borrow<address>(&arg0.whitelist_source_owners, arg1)
    }

    public(friend) fun whitelist_source_share_count<T0, T1: drop>(arg0: &StakeTicket<T0, T1>) : u64 {
        0x1::vector::length<address>(&arg0.whitelist_source_owners)
    }

    // decompiled from Move bytecode v6
}

