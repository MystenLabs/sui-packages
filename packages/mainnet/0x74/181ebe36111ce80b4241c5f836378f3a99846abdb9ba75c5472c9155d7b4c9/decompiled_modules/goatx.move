module 0x74181ebe36111ce80b4241c5f836378f3a99846abdb9ba75c5472c9155d7b4c9::goatx {
    struct GOATX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GOATX>(arg0, 6, b"GOATX", b"GOATX by SuiAI", b"Memes brought the masses. DeFi brought utility..GOAT X brings both - and adds true scarcity..Welcome to the GOAT X Meme-Fi movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2024_10_28_17_50_43_25983247fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOATX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

