module 0xafb1a50491e11a45728fc9ceea74d4315237db5b8c78c8b86c7dbb409e70885e::pidarass {
    struct PIDARASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIDARASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIDARASS>(arg0, 9, b"PIDARASS", b"Pedik", b"cry from the heart, all Bulgarians are faggots, who were dragging their peeing in different coins, let this coin not be like that, let it be free of faggots", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/752d77dc-cc75-4676-a5c8-b6a9ea89b72f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIDARASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIDARASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

