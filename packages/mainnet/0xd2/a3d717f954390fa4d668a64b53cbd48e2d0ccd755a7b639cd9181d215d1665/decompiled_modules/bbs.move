module 0xd2a3d717f954390fa4d668a64b53cbd48e2d0ccd755a7b639cd9181d215d1665::bbs {
    struct BBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBS>(arg0, 6, b"BBS", b"Bearbrick SUI", x"42656172627269636b202872656e64657265642042454052425249434b292069732061206272616e64206f6620636f6c6c65637469626c652064657369676e657220746f79732064657369676e656420616e642070726f647563656420627920746865204a6170616e65736520636f6d70616e79204d656469436f6d20546f7920496e636f72706f72617465642e0a546f6461792c2042656172627269636b206c61756e6368206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_72622339af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

