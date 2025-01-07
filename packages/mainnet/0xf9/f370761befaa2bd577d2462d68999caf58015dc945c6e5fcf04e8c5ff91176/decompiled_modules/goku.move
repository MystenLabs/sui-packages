module 0xf9f370761befaa2bd577d2462d68999caf58015dc945c6e5fcf04e8c5ff91176::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 6, b"GOKU", b"GokuMemeSUI", b"Goku meme on @SuiNetwork. Live on Turbos.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731059601513.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

