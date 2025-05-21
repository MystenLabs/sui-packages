module 0x67a4708740dcc8cfd86aea52b11d1972fe1fd9e9f3070b49763d55fe609611a1::sq {
    struct AC has store, key {
        id: 0x2::object::UID,
    }

    struct SQR has store, key {
        id: 0x2::object::UID,
        ci: u64,
        allowed: 0x2::vec_set::VecSet<address>,
    }

    public fun new(arg0: &AC, arg1: &mut 0x2::tx_context::TxContext) : address {
        let v0 = SQR{
            id      : 0x2::object::new(arg1),
            ci      : 0,
            allowed : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<SQR>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    public fun cii(arg0: &mut SQR, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) : u64 {
        vaw(arg0, arg3);
        if (arg1 <= arg0.ci) {
            assert!(arg2, 13371);
            return 13371
        };
        arg0.ci = arg1;
        0
    }

    public fun ciit(arg0: &mut SQR, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::tx_context::TxContext) : u64 {
        vaw(arg0, arg5);
        let v0 = cii(arg0, arg2, arg4, arg5);
        if (v0 != 0) {
            return v0
        };
        let v1 = ct(arg1, arg3, arg4);
        if (v1 != 0) {
            return v1
        };
        0
    }

    public fun ct(arg0: &0x2::clock::Clock, arg1: u64, arg2: bool) : u64 {
        if (arg1 < 0x2::clock::timestamp_ms(arg0)) {
            assert!(arg2, 13372);
            return 13372
        };
        0
    }

    public fun daw(arg0: &mut SQR, arg1: &AC, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.allowed, &arg2);
    }

    public fun dsa(arg0: SQR, arg1: &AC) {
        let SQR {
            id      : v0,
            ci      : _,
            allowed : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun iaw(arg0: &mut SQR, arg1: &AC, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.allowed, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AC{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AC>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun r(arg0: &mut SQR, arg1: &0x2::tx_context::TxContext) {
        vaw(arg0, arg1);
        arg0.ci = 0;
    }

    public fun tac(arg0: AC, arg1: address) {
        0x2::transfer::public_transfer<AC>(arg0, arg1);
    }

    fun vaw(arg0: &SQR, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.allowed, &v0), 13373);
    }

    // decompiled from Move bytecode v6
}

