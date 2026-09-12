module 0x22a6cb2a07a9c6b20bef581c5861d15037e2caddef1deaf5f999bd84a4aae7ac::vidtest {
    struct VIDTEST has drop {
        dummy_field: bool,
    }

    struct TestCard has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: VIDTEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<VIDTEST>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = TestCard{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(b"Video Face Test"),
        };
        0x2::transfer::public_transfer<TestCard>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TestCard{
            id   : 0x2::object::new(arg3),
            name : arg1,
        };
        0x2::transfer::public_transfer<TestCard>(v0, arg2);
    }

    // decompiled from Move bytecode v7
}

