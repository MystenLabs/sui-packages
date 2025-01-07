module 0x3bf76c8696c1bdc1913a84af2358592df43f7de73177f46bd88b59d2bf2ae662::admin {
    struct ContractPublisher has key {
        id: 0x2::object::UID,
    }

    struct ContractManager has key {
        id: 0x2::object::UID,
        manager_adress: address,
    }

    struct BlackList has key {
        id: 0x2::object::UID,
        list: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct GoldList has key {
        id: 0x2::object::UID,
        list: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct BlockList has key {
        id: 0x2::object::UID,
        list: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct ReservedDummyNFTList has key {
        id: 0x2::object::UID,
        list: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct FrequentWordList has key {
        id: 0x2::object::UID,
        tier_1: vector<0x1::string::String>,
        tier_2: vector<0x1::string::String>,
        tier_3: vector<0x1::string::String>,
        tier_4: vector<0x1::string::String>,
        tier_5: vector<0x1::string::String>,
        tier_6: vector<0x1::string::String>,
    }

    struct RewardPool has store, key {
        id: 0x2::object::UID,
    }

    struct Dummy2Pool has store, key {
        id: 0x2::object::UID,
    }

    struct CouponDetails has store {
        is_private: bool,
        is_special: bool,
        end_time: u64,
        discount_percentage: u64,
        eligible_addresses: 0x2::table::Table<address, u64>,
        claimed_addresses: 0x2::table::Table<address, bool>,
        max_redeemtion: u64,
    }

    struct CouponInfo has store, key {
        id: 0x2::object::UID,
        lists: 0x2::table::Table<0x1::string::String, CouponDetails>,
    }

    struct PriceModel has key {
        id: 0x2::object::UID,
        base_price: u64,
        gold_multipliers: u64,
        premium_multipliers: u64,
        tier_one_multipliers: u64,
        tier_two_multipliers: u64,
        tier_three_multipliers: u64,
        tier_four_multipliers: u64,
        tier_five_multipliers: u64,
        tier_six_multipliers: u64,
    }

    public entry fun accept_reward(arg0: &ContractPublisher, arg1: &mut RewardPool, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<0xde50a76dff821042299617e69c5067b8fe3e4a8f8c5857530dc5ecbd9a3f702c::dummy::DUMMY>>) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::coin::Coin<0xde50a76dff821042299617e69c5067b8fe3e4a8f8c5857530dc5ecbd9a3f702c::dummy::DUMMY>>(&mut arg1.id, 0x1::string::utf8(b"dummy"), 0x2::transfer::public_receive<0x2::coin::Coin<0xde50a76dff821042299617e69c5067b8fe3e4a8f8c5857530dc5ecbd9a3f702c::dummy::DUMMY>>(&mut arg1.id, arg2));
    }

    public fun add_block_list(arg0: &ContractPublisher, arg1: &mut BlockList, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            if (0x2::table::contains<0x1::string::String, bool>(&arg1.list, *v1) == false) {
                0x2::table::add<0x1::string::String, bool>(&mut arg1.list, *v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public fun add_frequent_word_list(arg0: &ContractPublisher, arg1: &mut FrequentWordList, arg2: vector<0x1::string::String>, arg3: u8) {
        if (arg3 == 1) {
            let v0 = 0;
            while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
                0x1::vector::push_back<0x1::string::String>(&mut arg1.tier_1, *0x1::vector::borrow<0x1::string::String>(&arg2, v0));
                v0 = v0 + 1;
            };
        } else if (arg3 == 2) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<0x1::string::String>(&arg2)) {
                0x1::vector::push_back<0x1::string::String>(&mut arg1.tier_2, *0x1::vector::borrow<0x1::string::String>(&arg2, v1));
                v1 = v1 + 1;
            };
        } else if (arg3 == 3) {
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x1::string::String>(&arg2)) {
                0x1::vector::push_back<0x1::string::String>(&mut arg1.tier_3, *0x1::vector::borrow<0x1::string::String>(&arg2, v2));
                v2 = v2 + 1;
            };
        } else if (arg3 == 4) {
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x1::string::String>(&arg2)) {
                0x1::vector::push_back<0x1::string::String>(&mut arg1.tier_4, *0x1::vector::borrow<0x1::string::String>(&arg2, v3));
                v3 = v3 + 1;
            };
        } else if (arg3 == 5) {
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::string::String>(&arg2)) {
                0x1::vector::push_back<0x1::string::String>(&mut arg1.tier_5, *0x1::vector::borrow<0x1::string::String>(&arg2, v4));
                v4 = v4 + 1;
            };
        } else if (arg3 == 6) {
            let v5 = 0;
            while (v5 < 0x1::vector::length<0x1::string::String>(&arg2)) {
                0x1::vector::push_back<0x1::string::String>(&mut arg1.tier_6, *0x1::vector::borrow<0x1::string::String>(&arg2, v5));
                v5 = v5 + 1;
            };
        };
    }

    public fun add_gold_dummy_nft(arg0: &ContractPublisher, arg1: &mut GoldList, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            if (0x2::table::contains<0x1::string::String, bool>(&arg1.list, *v1) == false) {
                0x2::table::add<0x1::string::String, bool>(&mut arg1.list, *v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public fun black_list_dummy_nft(arg0: &ContractPublisher, arg1: &mut BlackList, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            if (0x2::table::contains<0x1::string::String, bool>(&arg1.list, *v1) == false) {
                0x2::table::add<0x1::string::String, bool>(&mut arg1.list, *v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public fun check_is_coupon_special(arg0: 0x1::string::String, arg1: &CouponInfo) : bool {
        if (0x2::table::contains<0x1::string::String, CouponDetails>(&arg1.lists, arg0)) {
            if (0x2::table::borrow<0x1::string::String, CouponDetails>(&arg1.lists, arg0).is_special) {
                return true
            };
            return false
        };
        false
    }

    public fun claim_coupon_discount_percentage(arg0: 0x1::string::String, arg1: &mut CouponInfo, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        if (0x2::table::contains<0x1::string::String, CouponDetails>(&arg1.lists, arg0)) {
            let v0 = 0x2::table::borrow_mut<0x1::string::String, CouponDetails>(&mut arg1.lists, arg0);
            assert!(v0.end_time > 0x2::clock::timestamp_ms(arg2), 1003);
            if (v0.is_private) {
                assert!(0x2::table::contains<address, u64>(&v0.eligible_addresses, 0x2::tx_context::sender(arg3)), 1004);
                let v1 = 0x2::table::borrow_mut<address, u64>(&mut v0.eligible_addresses, 0x2::tx_context::sender(arg3));
                if (*v1 < v0.max_redeemtion) {
                    *v1 = *v1 + 1;
                    if (0x2::table::contains<address, bool>(&v0.claimed_addresses, 0x2::tx_context::sender(arg3)) == false) {
                        0x2::table::add<address, bool>(&mut v0.claimed_addresses, 0x2::tx_context::sender(arg3), true);
                    };
                    return v0.discount_percentage
                };
            } else if (0x2::table::contains<address, bool>(&v0.claimed_addresses, 0x2::tx_context::sender(arg3)) == false) {
                0x2::table::add<address, bool>(&mut v0.claimed_addresses, 0x2::tx_context::sender(arg3), true);
                return v0.discount_percentage
            };
        };
        0
    }

    public entry fun create_discount_coupon(arg0: &ContractPublisher, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: vector<address>, arg7: &mut CouponInfo, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1) {
            let v1 = 0x2::table::new<address, u64>(arg10);
            let v2 = 0;
            while (v2 < 0x1::vector::length<address>(&arg6)) {
                0x2::table::add<address, u64>(&mut v1, 0x1::vector::remove<address>(&mut arg6, v2), 0);
                v2 = v2 + 1;
            };
            CouponDetails{is_private: arg1, is_special: arg2, end_time: 0x2::clock::timestamp_ms(arg9) + arg3, discount_percentage: arg4, eligible_addresses: v1, claimed_addresses: 0x2::table::new<address, bool>(arg10), max_redeemtion: arg8}
        } else {
            CouponDetails{is_private: arg1, is_special: arg2, end_time: 0x2::clock::timestamp_ms(arg9) + arg3, discount_percentage: arg4, eligible_addresses: 0x2::table::new<address, u64>(arg10), claimed_addresses: 0x2::table::new<address, bool>(arg10), max_redeemtion: 1}
        };
        0x2::table::add<0x1::string::String, CouponDetails>(&mut arg7.lists, arg5, v0);
    }

    public(friend) fun get_mutable_reference_to_contract_manager(arg0: &ContractManager) : address {
        arg0.manager_adress
    }

    public(friend) fun get_mutable_reference_to_reward_balance(arg0: &mut RewardPool) : &mut 0x2::balance::Balance<0xde50a76dff821042299617e69c5067b8fe3e4a8f8c5857530dc5ecbd9a3f702c::dummy::DUMMY> {
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"dummy")), 1002);
        0x2::coin::balance_mut<0xde50a76dff821042299617e69c5067b8fe3e4a8f8c5857530dc5ecbd9a3f702c::dummy::DUMMY>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::coin::Coin<0xde50a76dff821042299617e69c5067b8fe3e4a8f8c5857530dc5ecbd9a3f702c::dummy::DUMMY>>(&mut arg0.id, 0x1::string::utf8(b"dummy")))
    }

    public(friend) fun get_reference_from_black_list(arg0: &BlackList) : &0x2::table::Table<0x1::string::String, bool> {
        &arg0.list
    }

    public(friend) fun get_reference_from_block_list(arg0: &BlockList) : &0x2::table::Table<0x1::string::String, bool> {
        &arg0.list
    }

    public(friend) fun get_reference_from_gold_list(arg0: &GoldList) : &0x2::table::Table<0x1::string::String, bool> {
        &arg0.list
    }

    public(friend) fun get_reference_from_resereved_list(arg0: &ReservedDummyNFTList) : &0x2::table::Table<0x1::string::String, bool> {
        &arg0.list
    }

    public(friend) fun get_reference_from_tier_Five(arg0: &FrequentWordList) : &vector<0x1::string::String> {
        &arg0.tier_5
    }

    public(friend) fun get_reference_from_tier_Four(arg0: &FrequentWordList) : &vector<0x1::string::String> {
        &arg0.tier_4
    }

    public(friend) fun get_reference_from_tier_One(arg0: &FrequentWordList) : &vector<0x1::string::String> {
        &arg0.tier_1
    }

    public(friend) fun get_reference_from_tier_Six(arg0: &FrequentWordList) : &vector<0x1::string::String> {
        &arg0.tier_6
    }

    public(friend) fun get_reference_from_tier_Three(arg0: &FrequentWordList) : &vector<0x1::string::String> {
        &arg0.tier_3
    }

    public(friend) fun get_reference_from_tier_Two(arg0: &FrequentWordList) : &vector<0x1::string::String> {
        &arg0.tier_2
    }

    public(friend) fun get_reference_to_base_price(arg0: &PriceModel) : &u64 {
        &arg0.base_price
    }

    public(friend) fun get_reference_to_gold_multipliers(arg0: &PriceModel) : &u64 {
        &arg0.gold_multipliers
    }

    public(friend) fun get_reference_to_premium_multipliers(arg0: &PriceModel) : &u64 {
        &arg0.premium_multipliers
    }

    public(friend) fun get_reference_to_tier_five_multipliers(arg0: &PriceModel) : &u64 {
        &arg0.tier_five_multipliers
    }

    public(friend) fun get_reference_to_tier_four_multipliers(arg0: &PriceModel) : &u64 {
        &arg0.tier_four_multipliers
    }

    public(friend) fun get_reference_to_tier_one_multipliers(arg0: &PriceModel) : &u64 {
        &arg0.tier_one_multipliers
    }

    public(friend) fun get_reference_to_tier_six_multipliers(arg0: &PriceModel) : &u64 {
        &arg0.tier_six_multipliers
    }

    public(friend) fun get_reference_to_tier_three_multipliers(arg0: &PriceModel) : &u64 {
        &arg0.tier_three_multipliers
    }

    public(friend) fun get_reference_to_tier_two_multipliers(arg0: &PriceModel) : &u64 {
        &arg0.tier_two_multipliers
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BlackList{
            id   : 0x2::object::new(arg0),
            list : 0x2::table::new<0x1::string::String, bool>(arg0),
        };
        0x2::transfer::share_object<BlackList>(v0);
        let v1 = GoldList{
            id   : 0x2::object::new(arg0),
            list : 0x2::table::new<0x1::string::String, bool>(arg0),
        };
        0x2::transfer::share_object<GoldList>(v1);
        let v2 = BlockList{
            id   : 0x2::object::new(arg0),
            list : 0x2::table::new<0x1::string::String, bool>(arg0),
        };
        0x2::transfer::share_object<BlockList>(v2);
        let v3 = ReservedDummyNFTList{
            id   : 0x2::object::new(arg0),
            list : 0x2::table::new<0x1::string::String, bool>(arg0),
        };
        0x2::transfer::share_object<ReservedDummyNFTList>(v3);
        let v4 = CouponInfo{
            id    : 0x2::object::new(arg0),
            lists : 0x2::table::new<0x1::string::String, CouponDetails>(arg0),
        };
        0x2::transfer::share_object<CouponInfo>(v4);
        let v5 = FrequentWordList{
            id     : 0x2::object::new(arg0),
            tier_1 : 0x1::vector::empty<0x1::string::String>(),
            tier_2 : 0x1::vector::empty<0x1::string::String>(),
            tier_3 : 0x1::vector::empty<0x1::string::String>(),
            tier_4 : 0x1::vector::empty<0x1::string::String>(),
            tier_5 : 0x1::vector::empty<0x1::string::String>(),
            tier_6 : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<FrequentWordList>(v5);
        let v6 = PriceModel{
            id                     : 0x2::object::new(arg0),
            base_price             : 1000000000,
            gold_multipliers       : 500,
            premium_multipliers    : 100,
            tier_one_multipliers   : 100,
            tier_two_multipliers   : 80,
            tier_three_multipliers : 60,
            tier_four_multipliers  : 40,
            tier_five_multipliers  : 20,
            tier_six_multipliers   : 15,
        };
        0x2::transfer::share_object<PriceModel>(v6);
        let v7 = ContractManager{
            id             : 0x2::object::new(arg0),
            manager_adress : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<ContractManager>(v7);
        let v8 = ContractPublisher{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ContractPublisher>(v8, 0x2::tx_context::sender(arg0));
        let v9 = RewardPool{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RewardPool>(v9);
        let v10 = Dummy2Pool{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Dummy2Pool>(v10);
    }

    public entry fun receive_dummy2(arg0: &ContractPublisher, arg1: &mut Dummy2Pool, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<0x9bbaad124fa2a856ba7b59b65c08b66e39896e916953e52434c24be31440a793::dummy2::DUMMY2>>) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::coin::Coin<0x9bbaad124fa2a856ba7b59b65c08b66e39896e916953e52434c24be31440a793::dummy2::DUMMY2>>(&mut arg1.id, 0x1::string::utf8(b"dummy2"), 0x2::transfer::public_receive<0x2::coin::Coin<0x9bbaad124fa2a856ba7b59b65c08b66e39896e916953e52434c24be31440a793::dummy2::DUMMY2>>(&mut arg1.id, arg2));
    }

    public fun reserve_dummy_nft(arg0: &ContractPublisher, arg1: &mut ReservedDummyNFTList, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            if (0x2::table::contains<0x1::string::String, bool>(&arg1.list, *v1) == false) {
                0x2::table::add<0x1::string::String, bool>(&mut arg1.list, *v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun send_reward(arg0: &mut RewardPool, arg1: &mut 0x2::coin::Coin<0xde50a76dff821042299617e69c5067b8fe3e4a8f8c5857530dc5ecbd9a3f702c::dummy::DUMMY>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xde50a76dff821042299617e69c5067b8fe3e4a8f8c5857530dc5ecbd9a3f702c::dummy::DUMMY>(arg1) >= arg2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xde50a76dff821042299617e69c5067b8fe3e4a8f8c5857530dc5ecbd9a3f702c::dummy::DUMMY>>(0x2::coin::from_balance<0xde50a76dff821042299617e69c5067b8fe3e4a8f8c5857530dc5ecbd9a3f702c::dummy::DUMMY>(0x2::balance::split<0xde50a76dff821042299617e69c5067b8fe3e4a8f8c5857530dc5ecbd9a3f702c::dummy::DUMMY>(0x2::coin::balance_mut<0xde50a76dff821042299617e69c5067b8fe3e4a8f8c5857530dc5ecbd9a3f702c::dummy::DUMMY>(arg1), arg2), arg3), 0x2::object::uid_to_address(&arg0.id));
    }

    public entry fun top_up_dummy2(arg0: &mut Dummy2Pool, arg1: &mut 0x2::coin::Coin<0x9bbaad124fa2a856ba7b59b65c08b66e39896e916953e52434c24be31440a793::dummy2::DUMMY2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x9bbaad124fa2a856ba7b59b65c08b66e39896e916953e52434c24be31440a793::dummy2::DUMMY2>(arg1) >= arg2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9bbaad124fa2a856ba7b59b65c08b66e39896e916953e52434c24be31440a793::dummy2::DUMMY2>>(0x2::coin::from_balance<0x9bbaad124fa2a856ba7b59b65c08b66e39896e916953e52434c24be31440a793::dummy2::DUMMY2>(0x2::balance::split<0x9bbaad124fa2a856ba7b59b65c08b66e39896e916953e52434c24be31440a793::dummy2::DUMMY2>(0x2::coin::balance_mut<0x9bbaad124fa2a856ba7b59b65c08b66e39896e916953e52434c24be31440a793::dummy2::DUMMY2>(arg1), arg2), arg3), 0x2::object::uid_to_address(&arg0.id));
    }

    public fun update_base_price(arg0: &ContractPublisher, arg1: &mut PriceModel, arg2: u64) {
        arg1.base_price = arg2 * 100000000;
    }

    public fun update_contract_manager(arg0: &ContractPublisher, arg1: &mut ContractManager, arg2: address) {
        arg1.manager_adress = arg2;
    }

    public fun update_frequent_word_multipliers(arg0: &ContractPublisher, arg1: &mut PriceModel, arg2: u8, arg3: u64) {
        if (arg2 == 1) {
            arg1.tier_one_multipliers = arg3 * 10;
        } else if (arg2 == 2) {
            arg1.tier_two_multipliers = arg3 * 10;
        } else if (arg2 == 3) {
            arg1.tier_three_multipliers = arg3 * 10;
        } else if (arg2 == 4) {
            arg1.tier_four_multipliers = arg3 * 10;
        } else if (arg2 == 5) {
            arg1.tier_five_multipliers = arg3 * 10;
        } else if (arg2 == 6) {
            arg1.tier_six_multipliers = arg3 * 10;
        };
    }

    public fun update_gold_multipliers(arg0: &ContractPublisher, arg1: &mut PriceModel, arg2: u64) {
        arg1.gold_multipliers = arg2 * 10;
    }

    public fun update_premium_multipliers(arg0: &ContractPublisher, arg1: &mut PriceModel, arg2: u64) {
        arg1.premium_multipliers = arg2 * 10;
    }

    public(friend) fun withdraw_dummy2(arg0: &mut Dummy2Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9bbaad124fa2a856ba7b59b65c08b66e39896e916953e52434c24be31440a793::dummy2::DUMMY2> {
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"dummy2")), 1002);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::coin::Coin<0x9bbaad124fa2a856ba7b59b65c08b66e39896e916953e52434c24be31440a793::dummy2::DUMMY2>>(&mut arg0.id, 0x1::string::utf8(b"dummy2"));
        assert!(0x2::coin::value<0x9bbaad124fa2a856ba7b59b65c08b66e39896e916953e52434c24be31440a793::dummy2::DUMMY2>(v0) > arg1, 5);
        0x2::coin::split<0x9bbaad124fa2a856ba7b59b65c08b66e39896e916953e52434c24be31440a793::dummy2::DUMMY2>(v0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

