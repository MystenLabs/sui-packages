module 0xa23d8253a2cb7517f11589b25993cbe52d957c422f3fcfac7a43b8b44a158bc8::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        next_id: u64,
        creation_fee_raw: u64,
        min_lp_seed_raw: u64,
        dev_wallet: address,
        tokens: 0x2::table::Table<u64, MemeEntry>,
    }

    struct MemeEntry has store {
        token_id: u64,
        coin_type: 0x1::ascii::String,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        image: 0x1::string::String,
        creator: address,
        pool_id: 0x2::object::ID,
        locker_id: 0x2::object::ID,
        agent_seed: u64,
        created_at_ms: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MemeLandLaunched has copy, drop {
        token_id: u64,
        coin_type: 0x1::ascii::String,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        image: 0x1::string::String,
        creator: address,
        pool_id: 0x2::object::ID,
        locker_id: 0x2::object::ID,
        agent_seed_raw: u64,
        fee_paid_raw: u64,
    }

    struct ConfigUpdated has copy, drop {
        new_creation_fee_raw: u64,
        new_min_lp_seed_raw: u64,
        new_dev_wallet: address,
    }

    public fun creation_fee(arg0: &Registry) : u64 {
        arg0.creation_fee_raw
    }

    public fun dev_wallet(arg0: &Registry) : address {
        arg0.dev_wallet
    }

    public fun has_token(arg0: &Registry, arg1: u64) : bool {
        0x2::table::contains<u64, MemeEntry>(&arg0.tokens, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id               : 0x2::object::new(arg0),
            next_id          : 0,
            creation_fee_raw : 1000000000000,
            min_lp_seed_raw  : 1000000000000,
            dev_wallet       : 0x2::tx_context::sender(arg0),
            tokens           : 0x2::table::new<u64, MemeEntry>(arg0),
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun min_lp_seed(arg0: &Registry) : u64 {
        arg0.min_lp_seed_raw
    }

    public fun next_id(arg0: &Registry) : u64 {
        arg0.next_id
    }

    public entry fun register_launch<T0, T1>(arg0: &mut Registry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())) == b"5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT", 3);
        assert!(0x2::coin::value<T1>(&arg7) >= arg0.creation_fee_raw, 1);
        assert!(arg6 >= arg0.min_lp_seed_raw, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg7, arg0.creation_fee_raw, arg9), arg0.dev_wallet);
        if (0x2::coin::value<T1>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg7, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<T1>(arg7);
        };
        let v0 = arg0.next_id;
        arg0.next_id = v0 + 1;
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = MemeEntry{
            token_id      : v0,
            coin_type     : v1,
            name          : 0x1::string::utf8(arg1),
            symbol        : 0x1::string::utf8(arg2),
            image         : 0x1::string::utf8(arg3),
            creator       : 0x2::tx_context::sender(arg9),
            pool_id       : arg4,
            locker_id     : arg5,
            agent_seed    : arg6,
            created_at_ms : 0x2::clock::timestamp_ms(arg8),
        };
        let v3 = MemeLandLaunched{
            token_id       : v0,
            coin_type      : v1,
            name           : v2.name,
            symbol         : v2.symbol,
            image          : v2.image,
            creator        : v2.creator,
            pool_id        : arg4,
            locker_id      : arg5,
            agent_seed_raw : arg6,
            fee_paid_raw   : arg0.creation_fee_raw,
        };
        0x2::event::emit<MemeLandLaunched>(v3);
        0x2::table::add<u64, MemeEntry>(&mut arg0.tokens, v0, v2);
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: address) {
        arg1.creation_fee_raw = arg2;
        arg1.min_lp_seed_raw = arg3;
        arg1.dev_wallet = arg4;
        let v0 = ConfigUpdated{
            new_creation_fee_raw : arg2,
            new_min_lp_seed_raw  : arg3,
            new_dev_wallet       : arg4,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

