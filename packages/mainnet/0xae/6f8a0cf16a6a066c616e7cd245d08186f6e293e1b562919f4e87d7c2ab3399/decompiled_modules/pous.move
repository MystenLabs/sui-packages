module 0xae6f8a0cf16a6a066c616e7cd245d08186f6e293e1b562919f4e87d7c2ab3399::pous {
    struct POUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POUS>(arg0, 6, b"POUS", b"Pou Sui", b"Meet Pou Sui, your friendly emotion buddy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/combined_image_new_3c13c26a73.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

