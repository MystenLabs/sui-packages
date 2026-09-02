module 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::key_registry {
    struct PublishedKey has copy, drop, store {
        x25519_public: vector<u8>,
        version: u64,
        updated_at_ms: u64,
    }

    struct KeyRegistry has key {
        id: 0x2::object::UID,
        keys: 0x2::table::Table<address, PublishedKey>,
    }

    struct KeyPublished has copy, drop {
        owner: address,
        x25519_public: vector<u8>,
        version: u64,
        updated_at_ms: u64,
    }

    struct KeyRevoked has copy, drop {
        owner: address,
        version: u64,
    }

    struct HighWater has copy, drop, store {
        owner: address,
    }

    fun assert_key_plausible(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 1);
        let v0 = 0;
        let v1 = false;
        while (v0 < 32) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != 0) {
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 2);
    }

    public fun has_key(arg0: &KeyRegistry, arg1: address) : bool {
        0x2::table::contains<address, PublishedKey>(&arg0.keys, arg1)
    }

    public fun high_water(arg0: &KeyRegistry, arg1: address) : u64 {
        let v0 = HighWater{owner: arg1};
        if (0x2::dynamic_field::exists<HighWater>(&arg0.id, v0)) {
            let v2 = HighWater{owner: arg1};
            *0x2::dynamic_field::borrow<HighWater, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KeyRegistry{
            id   : 0x2::object::new(arg0),
            keys : 0x2::table::new<address, PublishedKey>(arg0),
        };
        0x2::transfer::share_object<KeyRegistry>(v0);
    }

    public fun key_bytes() : u64 {
        32
    }

    public fun key_of(arg0: &KeyRegistry, arg1: address) : vector<u8> {
        assert!(0x2::table::contains<address, PublishedKey>(&arg0.keys, arg1), 3);
        0x2::table::borrow<address, PublishedKey>(&arg0.keys, arg1).x25519_public
    }

    fun next_version_for(arg0: &KeyRegistry, arg1: address) : u64 {
        let v0 = HighWater{owner: arg1};
        if (0x2::dynamic_field::exists<HighWater>(&arg0.id, v0)) {
            let v2 = HighWater{owner: arg1};
            *0x2::dynamic_field::borrow<HighWater, u64>(&arg0.id, v2) + 1
        } else {
            1
        }
    }

    public fun publish(arg0: &mut KeyRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_key_plausible(&arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = if (0x2::table::contains<address, PublishedKey>(&arg0.keys, v0)) {
            let v3 = 0x2::table::borrow_mut<address, PublishedKey>(&mut arg0.keys, v0);
            if (!(v3.x25519_public == arg1)) {
                v3.x25519_public = arg1;
                v3.version = v3.version + 1;
            };
            v3.updated_at_ms = v1;
            let v4 = v3.version;
            remember_high_water(arg0, v0, v4);
            v4
        } else {
            let v5 = next_version_for(arg0, v0);
            let v6 = PublishedKey{
                x25519_public : arg1,
                version       : v5,
                updated_at_ms : v1,
            };
            0x2::table::add<address, PublishedKey>(&mut arg0.keys, v0, v6);
            remember_high_water(arg0, v0, v5);
            v5
        };
        let v7 = KeyPublished{
            owner         : v0,
            x25519_public : arg1,
            version       : v2,
            updated_at_ms : v1,
        };
        0x2::event::emit<KeyPublished>(v7);
    }

    fun remember_high_water(arg0: &mut KeyRegistry, arg1: address, arg2: u64) {
        let v0 = HighWater{owner: arg1};
        if (0x2::dynamic_field::exists<HighWater>(&arg0.id, v0)) {
            let v1 = HighWater{owner: arg1};
            let v2 = 0x2::dynamic_field::borrow_mut<HighWater, u64>(&mut arg0.id, v1);
            if (arg2 > *v2) {
                *v2 = arg2;
            };
        } else {
            let v3 = HighWater{owner: arg1};
            0x2::dynamic_field::add<HighWater, u64>(&mut arg0.id, v3, arg2);
        };
    }

    public fun revoke(arg0: &mut KeyRegistry, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, PublishedKey>(&arg0.keys, v0), 3);
        let PublishedKey {
            x25519_public : _,
            version       : v2,
            updated_at_ms : _,
        } = 0x2::table::remove<address, PublishedKey>(&mut arg0.keys, v0);
        remember_high_water(arg0, v0, v2);
        let v4 = KeyRevoked{
            owner   : v0,
            version : v2,
        };
        0x2::event::emit<KeyRevoked>(v4);
    }

    public fun try_key_of(arg0: &KeyRegistry, arg1: address) : 0x1::option::Option<vector<u8>> {
        if (0x2::table::contains<address, PublishedKey>(&arg0.keys, arg1)) {
            0x1::option::some<vector<u8>>(0x2::table::borrow<address, PublishedKey>(&arg0.keys, arg1).x25519_public)
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun updated_at_ms_of(arg0: &KeyRegistry, arg1: address) : u64 {
        assert!(0x2::table::contains<address, PublishedKey>(&arg0.keys, arg1), 3);
        0x2::table::borrow<address, PublishedKey>(&arg0.keys, arg1).updated_at_ms
    }

    public fun version_of(arg0: &KeyRegistry, arg1: address) : u64 {
        assert!(0x2::table::contains<address, PublishedKey>(&arg0.keys, arg1), 3);
        0x2::table::borrow<address, PublishedKey>(&arg0.keys, arg1).version
    }

    // decompiled from Move bytecode v7
}

