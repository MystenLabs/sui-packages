module 0x8efa0362f36402875081a55e07cf1982b60cc5a2d598756b1a7119615232774a::tarzan {
    struct TARZAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARZAN>(arg0, 6, b"TARZAN", b"TARZANSUI", b"$TARZAN Meme token Sui chains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730981699265.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARZAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

