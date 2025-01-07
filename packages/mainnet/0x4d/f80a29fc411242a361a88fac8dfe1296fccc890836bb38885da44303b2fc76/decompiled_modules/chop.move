module 0x4df80a29fc411242a361a88fac8dfe1296fccc890836bb38885da44303b2fc76::chop {
    struct CHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOP>(arg0, 6, b"Chop", b"Chop Sui", x"4d617374657220436865662066726f6d207468652053656120636f6f6b696e672075702074686520686173206265656e20636861696e73206f66204574682c20536f6c20616e64205452580a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/photo_2024_09_24_13_38_39_dda5a69498.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

