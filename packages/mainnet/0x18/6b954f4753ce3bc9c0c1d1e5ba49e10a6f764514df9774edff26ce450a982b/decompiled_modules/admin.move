module 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin {
    struct ContractPublisher has store, key {
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

    struct ReservedChannelList has key {
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

    struct CouponDetails has copy, drop, store {
        is_private: bool,
        is_special: bool,
        end_time: u64,
        discount_percentage: u64,
        eligible_addresses: 0x2::vec_map::VecMap<address, u64>,
        claimed_addresses: vector<address>,
        max_redeemtion: u64,
    }

    struct CouponInfo has key {
        id: 0x2::object::UID,
        lists: 0x2::table::Table<vector<u8>, CouponDetails>,
    }

    struct CouponInfoV2 has key {
        id: 0x2::object::UID,
        lists: 0x2::table::Table<vector<u8>, CouponDetails>,
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

    public entry fun accept_reward(arg0: &ContractPublisher, arg1: &mut RewardPool, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>>) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::coin::Coin<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>>(&mut arg1.id, 0x1::string::utf8(b"movie"), 0x2::transfer::public_receive<0x2::coin::Coin<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>>(&mut arg1.id, arg2));
    }

    public fun add_block_list(arg0: &ContractPublisher, arg1: &mut BlockList, arg2: &mut vector<0x1::string::String>) {
        while (!0x1::vector::is_empty<0x1::string::String>(arg2)) {
            let v0 = 0x1::vector::pop_back<0x1::string::String>(arg2);
            if (!0x2::table::contains<0x1::string::String, bool>(&arg1.list, v0)) {
                0x2::table::add<0x1::string::String, bool>(&mut arg1.list, v0, true);
            };
        };
    }

    public fun add_frequent_word_list(arg0: &ContractPublisher, arg1: &mut FrequentWordList, arg2: vector<0x1::string::String>, arg3: u8) {
        assert!(arg3 >= 1 && arg3 <= 6, 24);
        if (arg3 == 1) {
            0x1::vector::append<0x1::string::String>(&mut arg1.tier_1, arg2);
        } else if (arg3 == 2) {
            0x1::vector::append<0x1::string::String>(&mut arg1.tier_2, arg2);
        } else if (arg3 == 3) {
            0x1::vector::append<0x1::string::String>(&mut arg1.tier_3, arg2);
        } else if (arg3 == 4) {
            0x1::vector::append<0x1::string::String>(&mut arg1.tier_4, arg2);
        } else if (arg3 == 5) {
            0x1::vector::append<0x1::string::String>(&mut arg1.tier_5, arg2);
        } else {
            0x1::vector::append<0x1::string::String>(&mut arg1.tier_6, arg2);
        };
    }

    public fun add_gold_channel(arg0: &ContractPublisher, arg1: &mut GoldList, arg2: &mut vector<0x1::string::String>) {
        while (!0x1::vector::is_empty<0x1::string::String>(arg2)) {
            let v0 = 0x1::vector::pop_back<0x1::string::String>(arg2);
            if (!0x2::table::contains<0x1::string::String, bool>(&arg1.list, v0)) {
                0x2::table::add<0x1::string::String, bool>(&mut arg1.list, v0, true);
            };
        };
    }

    public fun black_list_channel(arg0: &ContractPublisher, arg1: &mut BlackList, arg2: &mut vector<0x1::string::String>) {
        while (!0x1::vector::is_empty<0x1::string::String>(arg2)) {
            let v0 = 0x1::vector::pop_back<0x1::string::String>(arg2);
            if (!0x2::table::contains<0x1::string::String, bool>(&arg1.list, v0)) {
                0x2::table::add<0x1::string::String, bool>(&mut arg1.list, v0, true);
            };
        };
    }

    public fun check_is_coupon_special(arg0: vector<u8>, arg1: &CouponInfo) : bool {
        let v0 = 0x1::hash::sha2_256(arg0);
        if (0x2::table::contains<vector<u8>, CouponDetails>(&arg1.lists, v0)) {
            if (0x2::table::borrow<vector<u8>, CouponDetails>(&arg1.lists, v0).is_special) {
                return true
            };
            return false
        };
        false
    }

    public fun check_is_coupon_special_v2(arg0: vector<u8>, arg1: &CouponInfoV2) : bool {
        let v0 = 0x1::hash::sha2_256(arg0);
        if (0x2::table::contains<vector<u8>, CouponDetails>(&arg1.lists, v0)) {
            if (0x2::table::borrow<vector<u8>, CouponDetails>(&arg1.lists, v0).is_special) {
                return true
            };
            return false
        };
        false
    }

    public entry fun claim_coupon_discount_percentage(arg0: vector<u8>, arg1: &mut CouponInfo, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::hash::sha2_256(arg0);
        if (0x2::table::contains<vector<u8>, CouponDetails>(&arg1.lists, v0)) {
            let v1 = 0x2::table::borrow_mut<vector<u8>, CouponDetails>(&mut arg1.lists, v0);
            if (v1.end_time > 0x2::clock::timestamp_ms(arg2)) {
                if (v1.is_private) {
                    let v2 = 0x2::tx_context::sender(arg3);
                    assert!(0x2::vec_map::contains<address, u64>(&v1.eligible_addresses, &v2), 22);
                    let v3 = 0x2::tx_context::sender(arg3);
                    let v4 = 0x2::vec_map::get_mut<address, u64>(&mut v1.eligible_addresses, &v3);
                    if (*v4 < v1.max_redeemtion) {
                        *v4 = *v4 + 1;
                        let v5 = 0x2::tx_context::sender(arg3);
                        if (0x1::vector::contains<address>(&v1.claimed_addresses, &v5) == false) {
                            0x1::vector::push_back<address>(&mut v1.claimed_addresses, 0x2::tx_context::sender(arg3));
                        };
                        return v1.discount_percentage
                    };
                } else {
                    let v6 = 0x2::tx_context::sender(arg3);
                    if (0x1::vector::contains<address>(&v1.claimed_addresses, &v6) == false) {
                        0x1::vector::push_back<address>(&mut v1.claimed_addresses, 0x2::tx_context::sender(arg3));
                        return v1.discount_percentage
                    };
                };
            };
        };
        0
    }

    public entry fun claim_coupon_discount_percentage_v2(arg0: vector<u8>, arg1: &mut CouponInfoV2, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::hash::sha2_256(arg0);
        if (0x2::table::contains<vector<u8>, CouponDetails>(&arg1.lists, v0)) {
            let v1 = 0x2::table::borrow_mut<vector<u8>, CouponDetails>(&mut arg1.lists, v0);
            if (v1.end_time > 0x2::clock::timestamp_ms(arg2)) {
                if (v1.is_private) {
                    let v2 = 0x2::tx_context::sender(arg3);
                    assert!(0x2::vec_map::contains<address, u64>(&v1.eligible_addresses, &v2), 22);
                    let v3 = 0x2::tx_context::sender(arg3);
                    let v4 = 0x2::vec_map::get_mut<address, u64>(&mut v1.eligible_addresses, &v3);
                    if (*v4 < v1.max_redeemtion) {
                        *v4 = *v4 + 1;
                        let v5 = 0x2::tx_context::sender(arg3);
                        if (0x1::vector::contains<address>(&v1.claimed_addresses, &v5) == false) {
                            0x1::vector::push_back<address>(&mut v1.claimed_addresses, 0x2::tx_context::sender(arg3));
                        };
                        return v1.discount_percentage
                    };
                } else {
                    let v6 = 0x2::tx_context::sender(arg3);
                    if (0x1::vector::contains<address>(&v1.claimed_addresses, &v6) == false) {
                        0x1::vector::push_back<address>(&mut v1.claimed_addresses, 0x2::tx_context::sender(arg3));
                        return v1.discount_percentage
                    };
                };
            };
        };
        0
    }

    public fun create_Coupon_info_v2(arg0: &ContractPublisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CouponInfoV2{
            id    : 0x2::object::new(arg1),
            lists : 0x2::table::new<vector<u8>, CouponDetails>(arg1),
        };
        0x2::transfer::share_object<CouponInfoV2>(v0);
    }

    public entry fun create_discount_coupon(arg0: &ContractPublisher, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<address>, arg7: &mut CouponInfo, arg8: u64, arg9: &0x2::clock::Clock) {
        let v0 = if (arg1) {
            let v1 = 0x2::vec_map::empty<address, u64>();
            let v2 = 0;
            while (v2 < 0x1::vector::length<address>(&arg6)) {
                0x2::vec_map::insert<address, u64>(&mut v1, 0x1::vector::remove<address>(&mut arg6, v2), 0);
            };
            CouponDetails{is_private: arg1, is_special: arg2, end_time: 0x2::clock::timestamp_ms(arg9) + arg3, discount_percentage: arg4, eligible_addresses: v1, claimed_addresses: 0x1::vector::empty<address>(), max_redeemtion: arg8}
        } else {
            CouponDetails{is_private: arg1, is_special: false, end_time: 0x2::clock::timestamp_ms(arg9) + arg3, discount_percentage: arg4, eligible_addresses: 0x2::vec_map::empty<address, u64>(), claimed_addresses: 0x1::vector::empty<address>(), max_redeemtion: 1}
        };
        if (0x2::table::contains<vector<u8>, CouponDetails>(&arg7.lists, arg5)) {
            let v3 = 0x2::table::borrow_mut<vector<u8>, CouponDetails>(&mut arg7.lists, arg5);
            assert!(v3.end_time <= 0x2::clock::timestamp_ms(arg9), 23);
            *v3 = v0;
        } else {
            0x2::table::add<vector<u8>, CouponDetails>(&mut arg7.lists, arg5, v0);
        };
    }

    public entry fun create_discount_coupon_v2(arg0: &ContractPublisher, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<address>, arg7: &mut CouponInfoV2, arg8: u64, arg9: &0x2::clock::Clock) {
        let v0 = if (arg1) {
            let v1 = 0x2::vec_map::empty<address, u64>();
            let v2 = 0;
            while (v2 < 0x1::vector::length<address>(&arg6)) {
                0x2::vec_map::insert<address, u64>(&mut v1, 0x1::vector::remove<address>(&mut arg6, v2), 0);
            };
            CouponDetails{is_private: arg1, is_special: arg2, end_time: 0x2::clock::timestamp_ms(arg9) + arg3, discount_percentage: arg4, eligible_addresses: v1, claimed_addresses: 0x1::vector::empty<address>(), max_redeemtion: arg8}
        } else {
            CouponDetails{is_private: arg1, is_special: false, end_time: 0x2::clock::timestamp_ms(arg9) + arg3, discount_percentage: arg4, eligible_addresses: 0x2::vec_map::empty<address, u64>(), claimed_addresses: 0x1::vector::empty<address>(), max_redeemtion: 1}
        };
        if (0x2::table::contains<vector<u8>, CouponDetails>(&arg7.lists, arg5)) {
            let v3 = 0x2::table::borrow_mut<vector<u8>, CouponDetails>(&mut arg7.lists, arg5);
            assert!(v3.end_time <= 0x2::clock::timestamp_ms(arg9), 23);
            *v3 = v0;
        } else {
            0x2::table::add<vector<u8>, CouponDetails>(&mut arg7.lists, arg5, v0);
        };
    }

    public fun delete_Coupon_info_v1(arg0: &ContractPublisher, arg1: CouponInfo) {
        let CouponInfo {
            id    : v0,
            lists : v1,
        } = arg1;
        0x2::table::drop<vector<u8>, CouponDetails>(v1);
        0x2::object::delete(v0);
    }

    public(friend) fun get_mutable_reference_to_contract_manager(arg0: &ContractManager) : address {
        arg0.manager_adress
    }

    public(friend) fun get_mutable_reference_to_reward_balance(arg0: &mut RewardPool) : &mut 0x2::balance::Balance<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE> {
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"movie")), 20);
        0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::coin::Coin<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>>(&mut arg0.id, 0x1::string::utf8(b"movie")))
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

    public(friend) fun get_reference_from_resereved_list(arg0: &ReservedChannelList) : &0x2::table::Table<0x1::string::String, bool> {
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
        let v3 = ReservedChannelList{
            id   : 0x2::object::new(arg0),
            list : 0x2::table::new<0x1::string::String, bool>(arg0),
        };
        0x2::transfer::share_object<ReservedChannelList>(v3);
        let v4 = CouponInfo{
            id    : 0x2::object::new(arg0),
            lists : 0x2::table::new<vector<u8>, CouponDetails>(arg0),
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
            manager_adress : @0xc4b90789691abca8930eae09536be626baff2dbf17957b3110fc04c89ee711a4,
        };
        0x2::transfer::share_object<ContractManager>(v7);
        let v8 = ContractPublisher{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ContractPublisher>(v8, @0xf552fa8fa146ca342107052aa25c1bab900d3f9bf486c65f2607a5a077fff68f);
        let v9 = RewardPool{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RewardPool>(v9);
    }

    public fun remove_blacklisted_names(arg0: &ContractPublisher, arg1: &mut BlackList, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            if (0x2::table::contains<0x1::string::String, bool>(&arg1.list, *0x1::vector::borrow<0x1::string::String>(&arg2, v0))) {
                0x2::table::remove<0x1::string::String, bool>(&mut arg1.list, *0x1::vector::borrow<0x1::string::String>(&arg2, v0));
            };
            v0 = v0 + 1;
        };
    }

    public fun remove_blocklisted_names(arg0: &ContractPublisher, arg1: &mut BlockList, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            if (0x2::table::contains<0x1::string::String, bool>(&arg1.list, *0x1::vector::borrow<0x1::string::String>(&arg2, v0))) {
                0x2::table::remove<0x1::string::String, bool>(&mut arg1.list, *0x1::vector::borrow<0x1::string::String>(&arg2, v0));
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun remove_from_blacklist(arg0: &ContractPublisher, arg1: &mut BlackList, arg2: 0x1::string::String) {
        if (0x2::table::contains<0x1::string::String, bool>(&arg1.list, arg2)) {
            0x2::table::remove<0x1::string::String, bool>(&mut arg1.list, arg2);
        };
    }

    public(friend) fun remove_from_blocklist(arg0: &ContractPublisher, arg1: &mut BlockList, arg2: 0x1::string::String) {
        if (0x2::table::contains<0x1::string::String, bool>(&arg1.list, arg2)) {
            0x2::table::remove<0x1::string::String, bool>(&mut arg1.list, arg2);
        };
    }

    public fun remove_goldlisted_names(arg0: &ContractPublisher, arg1: &mut GoldList, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            if (0x2::table::contains<0x1::string::String, bool>(&arg1.list, *0x1::vector::borrow<0x1::string::String>(&arg2, v0))) {
                0x2::table::remove<0x1::string::String, bool>(&mut arg1.list, *0x1::vector::borrow<0x1::string::String>(&arg2, v0));
            };
            v0 = v0 + 1;
        };
    }

    public fun remove_premium_names(arg0: &ContractPublisher, arg1: &mut ReservedChannelList, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            if (0x2::table::contains<0x1::string::String, bool>(&arg1.list, *0x1::vector::borrow<0x1::string::String>(&arg2, v0))) {
                0x2::table::remove<0x1::string::String, bool>(&mut arg1.list, *0x1::vector::borrow<0x1::string::String>(&arg2, v0));
            };
            v0 = v0 + 1;
        };
    }

    public fun remove_tier_names(arg0: &ContractPublisher, arg1: &mut FrequentWordList, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let (v1, v2) = 0x1::vector::index_of<0x1::string::String>(&arg1.tier_1, 0x1::vector::borrow<0x1::string::String>(&arg2, v0));
            let (v3, v4) = 0x1::vector::index_of<0x1::string::String>(&arg1.tier_2, 0x1::vector::borrow<0x1::string::String>(&arg2, v0));
            let (v5, v6) = 0x1::vector::index_of<0x1::string::String>(&arg1.tier_3, 0x1::vector::borrow<0x1::string::String>(&arg2, v0));
            let (v7, v8) = 0x1::vector::index_of<0x1::string::String>(&arg1.tier_4, 0x1::vector::borrow<0x1::string::String>(&arg2, v0));
            let (v9, v10) = 0x1::vector::index_of<0x1::string::String>(&arg1.tier_5, 0x1::vector::borrow<0x1::string::String>(&arg2, v0));
            let (v11, v12) = 0x1::vector::index_of<0x1::string::String>(&arg1.tier_6, 0x1::vector::borrow<0x1::string::String>(&arg2, v0));
            if (v1) {
                0x1::vector::remove<0x1::string::String>(&mut arg1.tier_1, v2);
            } else if (v3) {
                0x1::vector::remove<0x1::string::String>(&mut arg1.tier_2, v4);
            } else if (v5) {
                0x1::vector::remove<0x1::string::String>(&mut arg1.tier_3, v6);
            } else if (v7) {
                0x1::vector::remove<0x1::string::String>(&mut arg1.tier_4, v8);
            } else if (v9) {
                0x1::vector::remove<0x1::string::String>(&mut arg1.tier_5, v10);
            } else if (v11) {
                0x1::vector::remove<0x1::string::String>(&mut arg1.tier_6, v12);
            };
            v0 = v0 + 1;
        };
    }

    public fun reserve_channel(arg0: &ContractPublisher, arg1: &mut ReservedChannelList, arg2: &mut vector<0x1::string::String>) {
        while (!0x1::vector::is_empty<0x1::string::String>(arg2)) {
            let v0 = 0x1::vector::pop_back<0x1::string::String>(arg2);
            if (!0x2::table::contains<0x1::string::String, bool>(&arg1.list, v0)) {
                0x2::table::add<0x1::string::String, bool>(&mut arg1.list, v0, true);
            };
        };
    }

    public entry fun send_reward(arg0: &mut RewardPool, arg1: &mut 0x2::coin::Coin<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(arg1) >= arg2, 21);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>>(0x2::coin::from_balance<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::balance::split<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(arg1), arg2), arg3), 0x2::object::uid_to_address(&arg0.id));
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

    // decompiled from Move bytecode v6
}

