module 0x144614c06e63faa658873d61a25e01dede105fc2e875cd10bdcc3652e8d86290::pega {
    struct PEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEGA>(arg0, 6, b"PEGA", b"Pepe Giga Chad", x"5065706520474947412043686164206973204865726521204269676765722c207374726f6e6765722c20616e6420726561647920746f20666c6578206f6e207468652063727970746f20776f726c642e2054686520756c74696d61746520616c706861206d656d652065766f6c7574696f6e206861732061727269766564210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SAL_8_F9_TR_400x400_f6c8b81084.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

