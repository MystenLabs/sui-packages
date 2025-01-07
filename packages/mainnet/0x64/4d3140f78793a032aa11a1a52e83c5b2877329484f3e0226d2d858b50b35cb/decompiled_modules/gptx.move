module 0x644d3140f78793a032aa11a1a52e83c5b2877329484f3e0226d2d858b50b35cb::gptx {
    struct GPTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPTX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GPTX>(arg0, 6, b"GPTX", b"GPTX", b"We will train this Agent to trade for us on DEXELERATE platform . GPTX agent should be able to buy the most hyped tokens . See our website  www,hedge4,Ai  ... see our team ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hedge4_logo_850ec49450.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GPTX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPTX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

