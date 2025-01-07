module 0xab95dbb6c1528b7ead5c9f9e9e1e571a36f054bc1460ace7890be2cbe5d7e606::chop {
    struct CHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOP>(arg0, 6, b"CHOP", b"Chop Sui", x"4d617374657220436865662066726f6d207468652053656120636f6f6b696e672075702074686520686173206265656e20636861696e73206f66204574682c20536f6c20616e64205452580a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_24_13_38_39_dda5a69498_ea85267223.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

