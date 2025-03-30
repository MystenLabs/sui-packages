module 0x9a99c309aaf9b79d355a91e6736603899ef5a22d5462233c598c3b00bc9de43e::pota {
    struct POTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTA>(arg0, 6, b"POTA", b"Sui Pota", b"POTA is strong memecoin on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052244_cc620e07f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

