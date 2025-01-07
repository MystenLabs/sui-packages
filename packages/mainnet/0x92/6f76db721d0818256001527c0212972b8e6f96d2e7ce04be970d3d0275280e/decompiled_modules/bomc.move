module 0x926f76db721d0818256001527c0212972b8e6f96d2e7ce04be970d3d0275280e::bomc {
    struct BOMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMC>(arg0, 6, b"BOMC", b"Book Of Meme Cat", x"426f6f6b204f66204d656d65204361742028424f4d43290a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C56y27_Kk_400x400_97644d2d2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

