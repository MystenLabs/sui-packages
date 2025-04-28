module 0xababd57332ef0977442733fa54ee4a2b68b3758f1c87b8f211d076f39117943c::cikcik {
    struct CIKCIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIKCIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIKCIK>(arg0, 6, b"Cikcik", b"Cikcik of Sui", x"4c6974746c652063696b63696b2020736d6f6c2c20637574652e2e2e206275742075682d6f682c2076657279206f7563686965206475636b79210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cikcik_logo_7edd5635e1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIKCIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIKCIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

