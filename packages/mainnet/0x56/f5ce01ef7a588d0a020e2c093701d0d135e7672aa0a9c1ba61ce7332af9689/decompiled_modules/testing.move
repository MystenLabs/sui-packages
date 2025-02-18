module 0x56f5ce01ef7a588d0a020e2c093701d0d135e7672aa0a9c1ba61ce7332af9689::testing {
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
        assert!(0x1::vector::length<u8>(&arg0.data) == 100, 0);
    }

    // decompiled from Move bytecode v6
}

