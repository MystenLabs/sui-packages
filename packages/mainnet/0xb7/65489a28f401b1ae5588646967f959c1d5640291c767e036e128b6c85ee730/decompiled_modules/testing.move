module 0xb765489a28f401b1ae5588646967f959c1d5640291c767e036e128b6c85ee730::testing {
    struct BigObject has key {
        id: 0x2::object::UID,
        data: vector<u8>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 100) {
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8));
            v1 = v1 + 1;
        };
        let v2 = BigObject{
            id   : 0x2::object::new(arg0),
            data : v0,
        };
        0x2::transfer::share_object<BigObject>(v2);
    }

    public fun mutate(arg0: &mut BigObject) {
        0x1::vector::push_back<u8>(&mut arg0.data, 1);
    }

    public fun read(arg0: &BigObject) {
        assert!(0x1::vector::length<u8>(&arg0.data) >= 0, 0);
    }

    // decompiled from Move bytecode v6
}

