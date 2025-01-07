module 0xe1ac7cfb5d9992684fbb11547377d818ff07d12c79885fdd339125bcde5d0cc4::suionke {
    struct SUIONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIONKE>(arg0, 6, b"SUIONKE", b"Ponke", b"Ponke On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5916_32b9063bc6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

