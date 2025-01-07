module 0xb75df5781e9539d944fe92752e1322dd03a2c5f7c27bef21a6a6f7994959c3a7::lollipop {
    struct LOLLIPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLLIPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLLIPOP>(arg0, 6, b"LOLLIPOP", b"Lollipop", b"MemeSuison and ride the Lollipop rocket!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730975244185.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLLIPOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLLIPOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

