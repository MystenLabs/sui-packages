module 0xafe7da7a1c4867845f84952d3c2de28ef4363e12ba8c66564f0dbd12fbcc71d2::giveaway {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        setup_cap_issued: bool,
        store_cap_issued: bool,
        listing_cap_issued: bool,
    }

    struct SetUpCap has store, key {
        id: 0x2::object::UID,
    }

    struct StoreCap has store, key {
        id: 0x2::object::UID,
    }

    struct ListingCap has store, key {
        id: 0x2::object::UID,
    }

    struct GiveawayReturn has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        generated_random_val: u64,
    }

    struct Metadata has copy, drop, store {
        claimed_giveaway_tickets: u64,
        remain_giveaway_tickets: u64,
    }

    struct GiveawayPool has key {
        id: 0x2::object::UID,
        reward_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        total_claim_count: u64,
        total_tier_1_claim_count: u64,
        total_tier_2_claim_count: u64,
        total_tier_3_claim_count: u64,
        total_tier_4_claim_count: u64,
        total_tier_5_claim_count: u64,
        total_used_claim: u64,
        total_used_tier_1_claim: u64,
        total_used_tier_2_claim: u64,
        total_used_tier_3_claim: u64,
        total_used_tier_4_claim: u64,
        total_used_tier_5_claim: u64,
        reward_list: 0x2::table_vec::TableVec<u64>,
        public_key: vector<u8>,
        allow_distribution: bool,
        prev_random: u64,
        random_table: 0x2::table::Table<address, u64>,
        whitelist_table: 0x2::table::Table<address, u8>,
        end_time: u64,
        return_address: address,
    }

    public fun add_funds_and_add_reward_list(arg0: SetUpCap, arg1: &mut GiveawayPool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 20000 * 1000000000, 0);
        let SetUpCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = 0;
        while (v1 < 800) {
            0x2::table_vec::push_back<u64>(&mut arg1.reward_list, 10000000000);
            v1 = v1 + 1;
        };
        assert!(0x2::table_vec::length<u64>(&arg1.reward_list) == 1121, 1);
    }

    public fun add_whitelist_users(arg0: &ListingCap, arg1: &mut GiveawayPool, arg2: vector<address>, arg3: vector<u8>) {
        assert!(0x1::vector::length<address>(&arg2) < 201, 8);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u8>(&arg3), 0);
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::table::add<address, u8>(&mut arg1.whitelist_table, 0x1::vector::pop_back<address>(&mut arg2), 0x1::vector::pop_back<u8>(&mut arg3));
        };
    }

    public fun burn_listing_cap(arg0: &AdminCap, arg1: ListingCap) {
        let ListingCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    fun bytes_to_u128(arg0: &vector<u8>) : u128 {
        let v0 = 0;
        assert!(0x1::vector::length<u8>(arg0) == 32, 0);
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u128);
            v1 = v1 + 1;
        };
        v0
    }

    fun generate_random_value_for_reward(arg0: vector<u8>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::bcs::to_bytes<u64>(&arg1);
        let v1 = 0x1::vector::empty<u8>();
        while (0x1::vector::length<u8>(&v0) > 0) {
            0x1::vector::push_back<u8>(&mut v1, 0x1::vector::pop_back<u8>(&mut v0));
        };
        while (0x1::vector::length<u8>(&arg0) > 0) {
            0x1::vector::push_back<u8>(&mut v1, 0x1::vector::pop_back<u8>(&mut arg0));
        };
        let v2 = 0x2::hash::blake2b256(&v1);
        get_random_u64_in_range(&v2, arg2)
    }

    fun get_random_u64(arg0: &vector<u8>) : u64 {
        ((bytes_to_u128(arg0) % 18446744073709551615) as u64)
    }

    fun get_random_u64_in_range(arg0: &vector<u8>, arg1: u64) : u64 {
        ((bytes_to_u128(arg0) % (arg1 as u128)) as u64)
    }

    public fun get_total_used_claim(arg0: &GiveawayPool) : u64 {
        arg0.total_used_claim
    }

    public fun get_user_random_val(arg0: &GiveawayPool, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.random_table, arg1) == false) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.random_table, arg1)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table_vec::empty<u64>(arg0);
        let v1 = 0;
        while (v1 < 321) {
            if (v1 == 0) {
                0x2::table_vec::push_back<u64>(&mut v0, 1000000000000);
            } else if (v1 > 0 && v1 <= 20) {
                0x2::table_vec::push_back<u64>(&mut v0, 100000000000);
            } else if (v1 > 20 && v1 <= 120) {
                0x2::table_vec::push_back<u64>(&mut v0, 50000000000);
            } else {
                assert!(v1 > 120 && v1 <= 320, 1);
                0x2::table_vec::push_back<u64>(&mut v0, 20000000000);
            };
            v1 = v1 + 1;
        };
        let v2 = GiveawayPool{
            id                       : 0x2::object::new(arg0),
            reward_pool              : 0x2::balance::zero<0x2::sui::SUI>(),
            total_claim_count        : 1121,
            total_tier_1_claim_count : 1,
            total_tier_2_claim_count : 20,
            total_tier_3_claim_count : 100,
            total_tier_4_claim_count : 200,
            total_tier_5_claim_count : 800,
            total_used_claim         : 0,
            total_used_tier_1_claim  : 0,
            total_used_tier_2_claim  : 0,
            total_used_tier_3_claim  : 0,
            total_used_tier_4_claim  : 0,
            total_used_tier_5_claim  : 0,
            reward_list              : v0,
            public_key               : 0x1::vector::empty<u8>(),
            allow_distribution       : true,
            prev_random              : 0,
            random_table             : 0x2::table::new<address, u64>(arg0),
            whitelist_table          : 0x2::table::new<address, u8>(arg0),
            end_time                 : 0,
            return_address           : 0x2::tx_context::sender(arg0),
        };
        let v3 = AdminCap{
            id                 : 0x2::object::new(arg0),
            setup_cap_issued   : false,
            store_cap_issued   : false,
            listing_cap_issued : false,
        };
        0x2::transfer::share_object<GiveawayPool>(v2);
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun initiate_claim_process(arg0: &mut GiveawayPool, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_time, 10);
        assert!(arg0.allow_distribution, 9);
        assert!(whitelisted(arg0, v0), 6);
        assert!(left_claim_count(arg0, v0) > 0, 7);
        assert!(0x2::table::contains<address, u64>(&arg0.random_table, v0) == false, 5);
        let v1 = 0x2::bcs::to_bytes<address>(&v0);
        0x1::vector::push_back<u8>(&mut v1, *0x2::table::borrow<address, u8>(&arg0.whitelist_table, v0));
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.public_key, &v1), 4);
        let v2 = 0x2::hash::blake2b256(&arg1);
        0x2::table::add<address, u64>(&mut arg0.random_table, v0, get_random_u64(&v2));
    }

    public fun left_claim_count(arg0: &GiveawayPool, arg1: address) : u8 {
        if (0x2::table::contains<address, u8>(&arg0.whitelist_table, arg1) == false) {
            0
        } else {
            *0x2::table::borrow<address, u8>(&arg0.whitelist_table, arg1)
        }
    }

    public fun mint_and_send_listingCap(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.listing_cap_issued == false, 11);
        let v0 = ListingCap{id: 0x2::object::new(arg2)};
        arg0.listing_cap_issued = true;
        0x2::transfer::public_transfer<ListingCap>(v0, arg1);
    }

    public fun mint_and_send_setupCap(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.setup_cap_issued == false, 11);
        let v0 = SetUpCap{id: 0x2::object::new(arg2)};
        arg0.setup_cap_issued = true;
        0x2::transfer::public_transfer<SetUpCap>(v0, arg1);
    }

    public fun mint_and_send_storeCap(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.store_cap_issued == false, 11);
        let v0 = StoreCap{id: 0x2::object::new(arg2)};
        arg0.store_cap_issued = true;
        0x2::transfer::public_transfer<StoreCap>(v0, arg1);
    }

    public fun receive_giveaway(arg0: &mut GiveawayPool, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.allow_distribution == true, 9);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_time, 10);
        assert!(arg0.total_claim_count > arg0.total_used_claim, 2);
        let v1 = 0x2::bcs::to_bytes<address>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(0x2::table::borrow<address, u64>(&arg0.random_table, v0)));
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.public_key, &v1), 4);
        let v2 = generate_random_value_for_reward(0x2::hash::blake2b256(&arg1), arg0.prev_random, arg0.total_claim_count - arg0.total_used_claim);
        arg0.prev_random = v2;
        let v3 = 0x2::table_vec::swap_remove<u64>(&mut arg0.reward_list, v2);
        if (v3 == 1000000000000) {
            assert!(arg0.total_tier_1_claim_count > arg0.total_used_tier_1_claim, 111);
            arg0.total_used_tier_1_claim = arg0.total_used_tier_1_claim + 1;
        } else if (v3 == 100000000000) {
            assert!(arg0.total_tier_2_claim_count > arg0.total_used_tier_2_claim, 222);
            arg0.total_used_tier_2_claim = arg0.total_used_tier_2_claim + 1;
        } else if (v3 == 50000000000) {
            assert!(arg0.total_tier_3_claim_count > arg0.total_used_tier_3_claim, 333);
            arg0.total_used_tier_3_claim = arg0.total_used_tier_3_claim + 1;
        } else if (v3 == 20000000000) {
            assert!(arg0.total_tier_4_claim_count > arg0.total_used_tier_4_claim, 444);
            arg0.total_used_tier_4_claim = arg0.total_used_tier_4_claim + 1;
        } else {
            assert!(v3 == 10000000000, 3);
            assert!(arg0.total_tier_5_claim_count > arg0.total_used_tier_5_claim, 555);
            arg0.total_used_tier_5_claim = arg0.total_used_tier_5_claim + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.reward_pool, v3, arg3), v0);
        arg0.total_used_claim = arg0.total_used_claim + 1;
        0x2::table::remove<address, u64>(&mut arg0.random_table, v0);
        let v4 = 0x2::table::borrow_mut<address, u8>(&mut arg0.whitelist_table, v0);
        *v4 = *v4 - 1;
        let v5 = Metadata{
            claimed_giveaway_tickets : arg0.total_used_claim,
            remain_giveaway_tickets  : arg0.total_claim_count - arg0.total_used_claim,
        };
        0x2::event::emit<Metadata>(v5);
        let v6 = GiveawayReturn{
            id                   : 0x2::object::id_from_address(v0),
            amount               : v3,
            recipient            : v0,
            generated_random_val : v2,
        };
        0x2::event::emit<GiveawayReturn>(v6);
    }

    public fun set_distribution(arg0: &AdminCap, arg1: &mut GiveawayPool, arg2: bool) {
        arg1.allow_distribution = arg2;
    }

    public fun set_end_time(arg0: &StoreCap, arg1: &mut GiveawayPool, arg2: u64) {
        arg1.end_time = arg2;
    }

    public fun set_public_key(arg0: &StoreCap, arg1: &mut GiveawayPool, arg2: vector<u8>) {
        arg1.public_key = arg2;
    }

    public fun set_return_address(arg0: &SetUpCap, arg1: &mut GiveawayPool, arg2: address) {
        arg1.return_address = arg2;
    }

    public fun tickets_claimed(arg0: &Metadata) : u64 {
        arg0.claimed_giveaway_tickets
    }

    public fun tickets_remained(arg0: &Metadata) : u64 {
        arg0.remain_giveaway_tickets
    }

    public fun whitelisted(arg0: &GiveawayPool, arg1: address) : bool {
        0x2::table::contains<address, u8>(&arg0.whitelist_table, arg1)
    }

    public fun withdraw_funds(arg0: &AdminCap, arg1: &mut GiveawayPool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.allow_distribution == false, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.reward_pool, 0x2::balance::value<0x2::sui::SUI>(&arg1.reward_pool), arg2), arg1.return_address);
    }

    public fun withdraw_remains(arg0: &AdminCap, arg1: &mut GiveawayPool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.end_time, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.reward_pool, 0x2::balance::value<0x2::sui::SUI>(&arg1.reward_pool), arg3), arg1.return_address);
    }

    // decompiled from Move bytecode v6
}

