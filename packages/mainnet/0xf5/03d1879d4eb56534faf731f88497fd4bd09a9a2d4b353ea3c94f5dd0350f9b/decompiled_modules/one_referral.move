module 0xf503d1879d4eb56534faf731f88497fd4bd09a9a2d4b353ea3c94f5dd0350f9b::one_referral {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        codes: 0x2::table::Table<0x1::string::String, address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CodeClaimed has copy, drop {
        code: 0x1::string::String,
        owner: address,
    }

    struct ReferredSwap has copy, drop {
        swapper: address,
        referrer: address,
        code: 0x1::string::String,
        amount: u64,
        measured: bool,
    }

    public fun bump_version(arg0: &AdminCap, arg1: &mut Registry) {
        assert!(arg1.version < 1, 3);
        arg1.version = 1;
    }

    public fun claim_code(arg0: &mut Registry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 3);
        assert!(is_valid(&arg1), 2);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.codes, arg1), 1);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::table::add<0x1::string::String, address>(&mut arg0.codes, arg1, v0);
        let v1 = CodeClaimed{
            code  : arg1,
            owner : v0,
        };
        0x2::event::emit<CodeClaimed>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            version : 1,
            codes   : 0x2::table::new<0x1::string::String, address>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_taken(arg0: &Registry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, address>(&arg0.codes, arg1)
    }

    fun is_valid(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0 || v1 > 32) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = if (v3 >= 97 && v3 <= 122) {
                true
            } else if (v3 >= 48 && v3 <= 57) {
                true
            } else if (v3 == 95) {
                true
            } else {
                v3 == 45
            };
            if (!v4) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun owner_of(arg0: &Registry, arg1: 0x1::string::String) : address {
        *0x2::table::borrow<0x1::string::String, address>(&arg0.codes, arg1)
    }

    public fun tag(arg0: address, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferredSwap{
            swapper  : 0x2::tx_context::sender(arg2),
            referrer : arg0,
            code     : arg1,
            amount   : 0,
            measured : false,
        };
        0x2::event::emit<ReferredSwap>(v0);
    }

    public fun tag_coin<T0>(arg0: address, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = ReferredSwap{
            swapper  : 0x2::tx_context::sender(arg3),
            referrer : arg0,
            code     : arg1,
            amount   : 0x2::coin::value<T0>(&arg2),
            measured : true,
        };
        0x2::event::emit<ReferredSwap>(v0);
        arg2
    }

    public fun version(arg0: &Registry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

