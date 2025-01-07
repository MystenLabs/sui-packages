module 0xb3ed4d59c8e00f3354385310eb0829e97d1851ce72d25a489b873b1984cf1ddf::hodi {
    struct HODI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODI>(arg0, 6, b"HODI", b"Cat in Hoodie", x"4a6f696e20746865204361742043617274656c20616e642073686f772074686f73652067656e697573207363616d6d6572732077686174207265616c2063727970746f20636174732063616e20646f2e20426563617573652c20636c6561726c792c20746865792074686f7567687420776564206a75737420736974206261636b20616e64206c6574207468656d2077696e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_X3_CCX_Tp_400x400_1_c6bf3627d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODI>>(v1);
    }

    // decompiled from Move bytecode v6
}

