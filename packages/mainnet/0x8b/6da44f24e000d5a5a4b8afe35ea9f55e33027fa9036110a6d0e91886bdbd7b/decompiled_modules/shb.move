module 0x8b6da44f24e000d5a5a4b8afe35ea9f55e33027fa9036110a6d0e91886bdbd7b::shb {
    struct SHB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHB>(arg0, 6, b"Shb", b"Shuiba", b"Shuiba si the Shiba of Sui! To all dog lovers..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_image_54_DBRU_70_1729362767532_raw_20e27f3505.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHB>>(v1);
    }

    // decompiled from Move bytecode v6
}

