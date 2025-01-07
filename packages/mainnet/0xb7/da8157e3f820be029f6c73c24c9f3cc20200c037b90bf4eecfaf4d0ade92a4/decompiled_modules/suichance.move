module 0xb7da8157e3f820be029f6c73c24c9f3cc20200c037b90bf4eecfaf4d0ade92a4::suichance {
    struct SUICHANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHANCE>(arg0, 9, b"SUICHANCE", b"CreateATokenFor20sui", b"542915069772 whatsapp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tse2.mm.bing.net/th?id=OIP.li43sSu2B0-gyXHtszHPZwHaD4&pid=Api&P=0&h=180")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICHANCE>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHANCE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

