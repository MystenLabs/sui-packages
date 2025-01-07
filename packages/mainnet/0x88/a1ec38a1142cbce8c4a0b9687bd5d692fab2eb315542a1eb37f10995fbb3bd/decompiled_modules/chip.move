module 0x88a1ec38a1142cbce8c4a0b9687bd5d692fab2eb315542a1eb37f10995fbb3bd::chip {
    struct CHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIP>(arg0, 6, b"CHIP", b"BLUE CHIP", b"DRAMATIC CHIPMUNK $CHIP IS A VIRAL INTERNET 5-SECOND CLIP OF A PRAIRIE DOG. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bc1_04bcadf8f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

