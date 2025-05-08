module 0x6b4b7f1b34316bcf67d5ea883b6c7050905f541a7045150ec4f6a7dd730162fe::sq {
    struct AC has key {
        id: 0x2::object::UID,
    }

    struct UC has store, key {
        id: 0x2::object::UID,
    }

    struct SQR has store, key {
        id: 0x2::object::UID,
        ci: u64,
    }

    public fun new(arg0: &AC, arg1: &mut 0x2::tx_context::TxContext) : address {
        let v0 = SQR{
            id : 0x2::object::new(arg1),
            ci : 0,
        };
        0x2::transfer::share_object<SQR>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    public fun cii(arg0: &mut SQR, arg1: &UC, arg2: u64, arg3: bool) : 0x1::option::Option<u64> {
        if (arg2 <= arg0.ci) {
            assert!(arg3, 13371);
            return 0x1::option::some<u64>(13371)
        };
        arg0.ci = arg2;
        0x1::option::none<u64>()
    }

    public fun ciit(arg0: &mut SQR, arg1: &UC, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool) : 0x1::option::Option<u64> {
        let v0 = cii(arg0, arg1, arg3, arg5);
        if (0x1::option::is_some<u64>(&v0)) {
            return v0
        };
        let v1 = ct(arg2, arg4, arg5);
        if (0x1::option::is_some<u64>(&v1)) {
            return v1
        };
        0x1::option::none<u64>()
    }

    public fun ct(arg0: &0x2::clock::Clock, arg1: u64, arg2: bool) : 0x1::option::Option<u64> {
        if (arg1 < 0x2::clock::timestamp_ms(arg0)) {
            assert!(arg2, 13372);
            return 0x1::option::some<u64>(13372)
        };
        0x1::option::none<u64>()
    }

    public fun dsa(arg0: SQR, arg1: &AC) {
        let SQR {
            id : v0,
            ci : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun dsu(arg0: SQR, arg1: &UC) {
        let SQR {
            id : v0,
            ci : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun duc(arg0: UC) {
        let UC { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AC{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AC>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun nuc(arg0: &AC, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = UC{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<UC>(v0, arg1);
    }

    public fun r(arg0: &mut SQR, arg1: &UC) {
        arg0.ci = 0;
    }

    public fun tac(arg0: AC, arg1: address) {
        0x2::transfer::transfer<AC>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

