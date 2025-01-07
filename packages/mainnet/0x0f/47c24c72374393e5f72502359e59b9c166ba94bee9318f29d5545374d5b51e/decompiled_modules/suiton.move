module 0xf47c24c72374393e5f72502359e59b9c166ba94bee9318f29d5545374d5b51e::suiton {
    struct SUITON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITON>(arg0, 6, b"SUITON", b"h2w6gm6jz", b"Nature is pleased with simplicity. And nature is no dummy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_5a29dc53ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITON>>(v1);
    }

    // decompiled from Move bytecode v6
}

