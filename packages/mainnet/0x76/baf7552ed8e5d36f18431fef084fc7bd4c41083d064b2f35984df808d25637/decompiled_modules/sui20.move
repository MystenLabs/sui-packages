module 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::sui20 {
    struct SUI20 has store, key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        utxo: 0x2::coin::Coin<0x2::sui::SUI>,
        balance: u64,
        image_url: 0x1::string::String,
        content_type: 0x1::string::String,
    }

    struct SUI20House has key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        lim: u64,
        cur: u64,
        max: u64,
        queue: 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::priority_queue::PriorityQueue<address>,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
        minimum_utxo: u64,
        account: 0x2::table::Table<address, u64>,
        maximum_one_account: u64,
        generate_time: u64,
        mist_round_message: u64,
        round: u64,
        image_url: 0x1::string::String,
    }

    public fun transfer(arg0: &mut SUI20House, arg1: u64, arg2: address) {
        assert!(arg0.cur >= arg0.max, 6);
        assert!(arg1 > 0, 0);
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.account, arg2);
        assert!(*v0 > arg1, 7);
        *v0 = *v0 - arg1;
        if (0x2::table::contains<address, u64>(&arg0.account, arg2)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.account, arg2);
            *v1 = *v1 + arg1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.account, arg2, arg1);
        };
    }

    public entry fun claim(arg0: &mut SUI20House, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.cur < arg0.max, 1);
        assert!(arg2 >= arg0.minimum_utxo, 0);
        assert!(get_account_balance(arg0, 0x2::tx_context::sender(arg3)) < arg0.maximum_one_account, 2);
        0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::priority_queue::insert<address>(&mut arg0.queue, arg2, 0x2::tx_context::sender(arg3));
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.minimum_utxo, 3);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.coin, 0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3));
    }

    public entry fun confirm_to_next_round(arg0: &mut SUI20House, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(arg0.cur < arg0.max, 1);
        assert!(arg0.round <= 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::calculate_round(0x2::clock::timestamp_ms(arg1)), 6);
        0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::verify_drand_signature(arg2, arg3, arg0.round);
        let v0 = arg0.lim;
        let v1 = 0;
        while (v1 < 0x2::math::min(arg0.mist_round_message, 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::priority_queue::length<address>(&arg0.queue))) {
            if (arg0.max - arg0.cur < v0) {
                v0 = arg0.max - arg0.cur;
            };
            let (_, v3) = 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::priority_queue::pop_max<address>(&mut arg0.queue);
            if (0x2::table::contains<address, u64>(&arg0.account, v3)) {
                let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.account, v3);
                let v5 = *v4 + v0;
                if (v5 > arg0.maximum_one_account) {
                    v1 = v1 + 1;
                    continue
                };
                *v4 = v5;
            } else {
                0x2::table::add<address, u64>(&mut arg0.account, v3, v0);
            };
            arg0.cur = arg0.cur + v0;
            v1 = v1 + 1;
        };
        arg0.round = arg0.round + 1;
    }

    public entry fun deploy(arg0: &mut 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::InscriptionHouse, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::Mist, arg9: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::is_deploy(arg0, arg1), 5);
        assert!(0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::mist_balance(&arg8) >= 100, 4);
        assert!(arg6 <= 1000, 0);
        if (0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::mist_balance(&arg8) > 100) {
            let (v0, v1) = 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::split(arg8, arg9, 100, arg11);
            0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::destroy(v1, arg11);
            0x2::transfer::public_transfer<0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::Mist>(v0, 0x2::tx_context::sender(arg11));
        } else {
            0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::destroy(arg8, arg11);
        };
        assert!(arg5 <= arg3, 0);
        assert!(arg2 <= arg3, 0);
        let v2 = 0x2::clock::timestamp_ms(arg10);
        let v3 = SUI20House{
            id                  : 0x2::object::new(arg11),
            tick                : arg1,
            lim                 : arg2,
            cur                 : 0,
            max                 : arg3,
            queue               : 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::priority_queue::new<address>(0x2::table_vec::empty<0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::priority_queue::Entry<address>>(arg11)),
            coin                : 0x2::coin::zero<0x2::sui::SUI>(arg11),
            minimum_utxo        : arg4,
            account             : 0x2::table::new<address, u64>(arg11),
            maximum_one_account : arg5,
            generate_time       : v2,
            mist_round_message  : arg6,
            round               : 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::calculate_round(v2 / 1000),
            image_url           : arg7,
        };
        0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::new_inscription(arg0, arg1, 0x2::object::id<SUI20House>(&v3));
        0x2::transfer::share_object<SUI20House>(v3);
    }

    public entry fun destroy_sui20(arg0: SUI20, arg1: address) {
        let SUI20 {
            id           : v0,
            tick         : _,
            utxo         : v2,
            balance      : _,
            image_url    : _,
            content_type : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, arg1);
    }

    public fun get_account_balance(arg0: &SUI20House, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.account, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.account, arg1)
        } else {
            0
        }
    }

    public entry fun merge_sui20(arg0: vector<SUI20>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<SUI20>(&arg0) >= 2, 8);
        let v0 = 0x1::vector::pop_back<SUI20>(&mut arg0);
        let v1 = 0x2::coin::zero<0x2::sui::SUI>(arg1);
        while (0x1::vector::length<SUI20>(&arg0) > 0) {
            let SUI20 {
                id           : v2,
                tick         : _,
                utxo         : v4,
                balance      : v5,
                image_url    : _,
                content_type : _,
            } = 0x1::vector::pop_back<SUI20>(&mut arg0);
            0x2::coin::join<0x2::sui::SUI>(&mut v1, v4);
            v0.balance = v0.balance + v5;
            0x2::object::delete(v2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<SUI20>(v0, 0x2::tx_context::sender(arg1));
        0x1::vector::destroy_empty<SUI20>(arg0);
    }

    public fun mint(arg0: &mut SUI20House, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.cur == arg0.max, 6);
        assert!(get_account_balance(arg0, 0x2::tx_context::sender(arg3)) > arg1, 3);
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.account, 0x2::tx_context::sender(arg3));
        *v0 = *v0 - arg1;
        let v1 = SUI20{
            id           : 0x2::object::new(arg3),
            tick         : arg0.tick,
            utxo         : 0x2::coin::split<0x2::sui::SUI>(arg2, arg0.minimum_utxo, arg3),
            balance      : arg1,
            image_url    : arg0.image_url,
            content_type : 0x1::string::utf8(b"sui-20"),
        };
        0x2::transfer::public_transfer<SUI20>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun object_to_indexer(arg0: &mut SUI20House, arg1: SUI20, arg2: address) {
        destroy_sui20(arg1, arg2);
        if (0x2::table::contains<address, u64>(&arg0.account, arg2)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.account, arg2);
            *v0 = *v0 + arg1.balance;
        } else {
            0x2::table::add<address, u64>(&mut arg0.account, arg2, arg1.balance);
        };
    }

    public entry fun set_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{tick}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://src-inscription.vercel.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{\"p\":\"sui-20\",\"op\":\"mint\",\"tick\":\"{tick}\",\"amt\":\"{balance}\"}"));
        0x2::transfer::public_transfer<0x2::display::Display<SUI20>>(0x2::display::new_with_fields<SUI20>(arg0, v0, v2, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun split_sui20(arg0: &mut SUI20House, arg1: SUI20, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (SUI20, SUI20) {
        assert!(arg3 > 0, 0);
        assert!(arg1.balance > arg3, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) > arg0.minimum_utxo, 3);
        arg1.balance = arg1.balance - arg3;
        let v0 = SUI20{
            id           : 0x2::object::new(arg4),
            tick         : arg1.tick,
            utxo         : 0x2::coin::split<0x2::sui::SUI>(arg2, arg0.minimum_utxo, arg4),
            balance      : arg3,
            image_url    : arg1.image_url,
            content_type : arg1.content_type,
        };
        (arg1, v0)
    }

    public entry fun split_sui20_script(arg0: &mut SUI20House, arg1: SUI20, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = split_sui20(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<SUI20>(v0, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<SUI20>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun sui20_balance(arg0: &SUI20) : u64 {
        arg0.balance
    }

    public fun sui20_coin_value(arg0: &SUI20) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.utxo)
    }

    public fun sui20_content_type(arg0: &SUI20) : 0x1::string::String {
        arg0.content_type
    }

    public fun sui20_image_url(arg0: &SUI20) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.utxo)
    }

    public fun sui20_tick(arg0: &SUI20) : 0x1::string::String {
        arg0.tick
    }

    // decompiled from Move bytecode v6
}

