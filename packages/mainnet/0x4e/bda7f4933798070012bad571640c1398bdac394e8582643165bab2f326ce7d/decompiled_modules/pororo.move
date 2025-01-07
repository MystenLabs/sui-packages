module 0x4ebda7f4933798070012bad571640c1398bdac394e8582643165bab2f326ce7d::pororo {
    struct PORORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORORO>(arg0, 6, b"PORORO", b"PororoSUI", b"Pororo appeared on Sui chain. Everyone gather here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_20_13_24_22_7b00218141.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

