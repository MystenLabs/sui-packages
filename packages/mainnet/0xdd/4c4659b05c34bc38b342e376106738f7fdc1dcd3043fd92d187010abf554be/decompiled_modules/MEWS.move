module 0xdd4c4659b05c34bc38b342e376106738f7fdc1dcd3043fd92d187010abf554be::MEWS {
    struct MEWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWS>(arg0, 6, b"Mewsell", b"MEWS", x"546865206c6567656e64617279206361742072657475726e732c20244d4557532e200a54686520776f726c642773207374726f6e676573742063617420726964657320746865207761766573206f6620746865206d656d6520636f696e206d61726b65742e20506f77657265642062792070757265206d7573636c652c204d657773656c6c206973206865726520746f20666c6578206f6e20616c6c20746865207765616b20746f6b656e732e205375726620746865206d656d652074696465207769746820756e73746f707061626c652063617420737472656e6774682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreihqqaqlym2fty7cs4n5igebbfhckjhimzqe673ppsqnteizshv3k4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWS>>(v0, @0xf4225f3f311cd5aa6ca53df437cb8cbd9d34b1bc979ff89e9356587692e21ebf);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

