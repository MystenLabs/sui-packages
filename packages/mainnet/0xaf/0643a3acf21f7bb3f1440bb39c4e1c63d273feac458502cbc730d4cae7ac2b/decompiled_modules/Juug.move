module 0xaf0643a3acf21f7bb3f1440bb39c4e1c63d273feac458502cbc730d4cae7ac2b::Juug {
    struct JUUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUUG>(arg0, 6, b"JUUG", b"JUUGG", b"JUUG: https://t.me/express_model_marketplace", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/valid-image-data")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUUG>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUUG>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

