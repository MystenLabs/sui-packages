module 0x309eedc9d1568e5e0dbac9dd65fc93c6e491b5d770791b9206bdf501f578793e::pui {
    struct PUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUI>(arg0, 6, b"PUI", b"Papa Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.myloview.ru/posters/illustrazione-festa-del-papa-con-cuori-color-bianco-e-carta-da-zucchero-700-87752735.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUI>(&mut v2, 55555555000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

