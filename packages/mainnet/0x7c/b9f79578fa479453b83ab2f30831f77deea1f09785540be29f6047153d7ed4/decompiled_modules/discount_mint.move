module 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::discount_mint {
    struct Pool has key {
        id: 0x2::object::UID,
        num: u64,
        price: u64,
        start_ms: u64,
        end_ms: u64,
        authority: address,
        public_key: vector<u8>,
        discount_pcts: vector<u64>,
        is_live: bool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        tails: 0x2::table_vec::TableVec<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>,
        requests: vector<MintRequest>,
    }

    struct MintRequest has store {
        user: address,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
        vrf_input: vector<u8>,
    }

    struct MintRequestEvent has copy, drop {
        user: address,
        vrf_input: vector<u8>,
        remaining: u64,
        seed: u64,
    }

    struct DiscountEventV3 has copy, drop {
        pool: 0x2::object::ID,
        price: u64,
        discount_pct: u64,
        discount_price: u64,
        user: address,
        vrf_input: vector<u8>,
        level: u64,
    }

    entry fun add_whitelist(arg0: &mut Pool, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.authority == 0x2::tx_context::sender(arg2), 0);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"whitelist"))) {
            let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, bool>>(&mut arg0.id, 0x1::string::utf8(b"whitelist"));
            while (!0x1::vector::is_empty<address>(&arg1)) {
                0x2::table::add<address, bool>(v0, 0x1::vector::pop_back<address>(&mut arg1), true);
            };
        } else {
            let v1 = 0x2::table::new<address, bool>(arg2);
            while (!0x1::vector::is_empty<address>(&arg1)) {
                0x2::table::add<address, bool>(&mut v1, 0x1::vector::pop_back<address>(&mut arg1), true);
            };
            0x2::dynamic_field::add<0x1::string::String, 0x2::table::Table<address, bool>>(&mut arg0.id, 0x1::string::utf8(b"whitelist"), v1);
        };
    }

    entry fun close(arg0: &mut Pool, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.authority == 0x2::tx_context::sender(arg1), 0);
        arg0.is_live = false;
    }

    entry fun deposit_nft(arg0: &mut Pool, arg1: 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails) {
        0x2::table_vec::push_back<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg0.tails, arg1);
    }

    entry fun execute_mint(arg0: &mut Pool, arg1: &0x2::transfer_policy::TransferPolicy<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.authority == 0x2::tx_context::sender(arg3), 0);
        let MintRequest {
            user      : v0,
            coin      : v1,
            vrf_input : v2,
        } = 0x1::vector::remove<MintRequest>(&mut arg0.requests, 0);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &arg0.public_key, &v3), 0);
        let v5 = 0x2::hash::blake2b256(&arg2);
        let v6 = 0x2::table_vec::length<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&arg0.tails);
        let v7 = if (v6 == 1) {
            0x2::table_vec::pop_back<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg0.tails)
        } else {
            0x2::table_vec::swap<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg0.tails, (generate_answer(v6, &v5) as u64), v6 - 1);
            0x2::table_vec::pop_back<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg0.tails)
        };
        let v8 = v7;
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::emit_mint_event(&v8, v0);
        let (v9, v10) = 0x2::kiosk::new(arg3);
        let v11 = v10;
        let v12 = v9;
        0x2::kiosk::lock<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut v12, &v11, arg1, v8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v12);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v11, v0);
        let v13 = 0x2::coin::into_balance<0x2::sui::SUI>(v4);
        let v14 = *0x1::vector::borrow<u64>(&arg0.discount_pcts, generate_answer(0x1::vector::length<u64>(&arg0.discount_pcts), &v5));
        let v15 = v14;
        if (0x2::coin::value<0x2::sui::SUI>(&v4) == arg0.price * 50 / 100) {
            v15 = 50;
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v13, arg0.price * v14 / 100, arg3), v0);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, v13);
        let v16 = DiscountEventV3{
            pool           : 0x2::object::id<Pool>(arg0),
            price          : arg0.price,
            discount_pct   : v15,
            discount_price : 0x2::balance::value<0x2::sui::SUI>(&v13),
            user           : v0,
            vrf_input      : v3,
            level          : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_level(&v8),
        };
        0x2::event::emit<DiscountEventV3>(v16);
    }

    fun generate_answer(arg0: u64, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 16, 6);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg1, v1) as u128);
            v1 = v1 + 1;
        };
        ((v0 % (arg0 as u128)) as u64)
    }

    public(friend) fun is_whitelist(arg0: &Pool, arg1: address) : bool {
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"whitelist"))) {
            if (0x2::table::contains<address, bool>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::table::Table<address, bool>>(&arg0.id, 0x1::string::utf8(b"whitelist")), arg1)) {
                return true
            };
        };
        false
    }

    entry fun migrate_nfts(arg0: &0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap, arg1: &mut 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Pool, arg2: u64, arg3: &mut Pool) {
        let v0 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::withdraw_nfts(arg0, arg1, arg2);
        while (!0x1::vector::is_empty<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v0)) {
            deposit_nft(arg3, 0x1::vector::pop_back<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut v0));
        };
        0x1::vector::destroy_empty<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v0);
    }

    entry fun new_pool(arg0: &0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id            : 0x2::object::new(arg6),
            num           : 0,
            price         : arg1,
            start_ms      : arg2,
            end_ms        : arg3,
            authority     : 0x2::tx_context::sender(arg6),
            public_key    : arg4,
            discount_pcts : arg5,
            is_live       : true,
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            tails         : 0x2::table_vec::empty<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg6),
            requests      : 0x1::vector::empty<MintRequest>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    entry fun new_round(arg0: &mut Pool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.authority == 0x2::tx_context::sender(arg5), 0);
        arg0.num = arg1;
        arg0.price = arg2;
        arg0.start_ms = arg3;
        arg0.end_ms = arg4;
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"total"))) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"total")) = arg1;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"total"), arg1);
        };
    }

    entry fun refund(arg0: &mut Pool, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.authority == 0x2::tx_context::sender(arg1), 0);
        let MintRequest {
            user      : v0,
            coin      : v1,
            vrf_input : _,
        } = 0x1::vector::remove<MintRequest>(&mut arg0.requests, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
    }

    entry fun request_mint(arg0: &mut Pool, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.price, 1);
        assert!(arg1 < 3, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.start_ms, 4);
        assert!(v0 < arg0.end_ms, 7);
        assert!(arg0.is_live, 5);
        let v1 = 0x2::object::id_bytes<Pool>(arg0);
        let v2 = arg0.num;
        assert!(v2 > 0, 3);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v0));
        let v3 = 0x2::tx_context::sender(arg4);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"whitelist"))) {
            let v4 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, bool>>(&mut arg0.id, 0x1::string::utf8(b"whitelist"));
            if (0x2::table::contains<address, bool>(v4, v3)) {
                0x2::table::remove<address, bool>(v4, v3);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.price * 50 / 100, arg4), v3);
            };
        };
        let v5 = MintRequest{
            user      : v3,
            coin      : arg2,
            vrf_input : v1,
        };
        0x1::vector::push_back<MintRequest>(&mut arg0.requests, v5);
        arg0.num = arg0.num - 1;
        let v6 = MintRequestEvent{
            user      : v3,
            vrf_input : v1,
            remaining : v2,
            seed      : arg1,
        };
        0x2::event::emit<MintRequestEvent>(v6);
    }

    entry fun update_discount_pcts(arg0: &mut Pool, arg1: vector<u64>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.authority == 0x2::tx_context::sender(arg2), 0);
        arg0.discount_pcts = arg1;
    }

    entry fun update_end_ms(arg0: &mut Pool, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.authority == 0x2::tx_context::sender(arg2), 0);
        arg0.end_ms = arg1;
    }

    entry fun withdraw_balance(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.authority == 0x2::tx_context::sender(arg1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg1), @0xe62c0a0509e2baa4700cd9b9bad8b1ba9296ecc1b36ff8122e29926efe1eb800);
    }

    // decompiled from Move bytecode v6
}

