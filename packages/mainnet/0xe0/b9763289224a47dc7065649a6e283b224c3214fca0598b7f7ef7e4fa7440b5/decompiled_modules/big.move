module 0xe0b9763289224a47dc7065649a6e283b224c3214fca0598b7f7ef7e4fa7440b5::big {
    struct HugeObject has store, key {
        id: 0x2::object::UID,
        data: vector<u8>,
    }

    public entry fun make_huge(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 1024) {
            0x1::vector::push_back<u8>(&mut v0, 171);
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<u8>();
        while (0x1::vector::length<u8>(&v2) < arg0) {
            0x1::vector::append<u8>(&mut v2, v0);
        };
        let v3 = HugeObject{
            id   : 0x2::object::new(arg1),
            data : v2,
        };
        0x2::transfer::transfer<HugeObject>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

