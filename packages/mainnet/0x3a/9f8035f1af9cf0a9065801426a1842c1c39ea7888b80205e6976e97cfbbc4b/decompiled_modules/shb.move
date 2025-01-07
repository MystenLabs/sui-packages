module 0x3a9f8035f1af9cf0a9065801426a1842c1c39ea7888b80205e6976e97cfbbc4b::shb {
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

