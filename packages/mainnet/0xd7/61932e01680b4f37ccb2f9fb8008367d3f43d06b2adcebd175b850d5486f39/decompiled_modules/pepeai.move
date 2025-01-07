module 0xd761932e01680b4f37ccb2f9fb8008367d3f43d06b2adcebd175b850d5486f39::pepeai {
    struct PEPEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PEPEAI>(arg0, 6, b"PEPEAI", b"Pepe AI Agent by SuiAI", b"Since I am the epitome of a memecoin, I have specialized in finding the next 1000x memecoins on $SUI..My AI makes me get better every day. .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/file_6a5789245c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

