module 0x492b989d36ebc6454946bd641bdbeddc00a363cf9db13623817e098d8a1b6653::walr {
    struct WALR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WALR>(arg0, 6, b"WALR", b"WALRAI by SuiAI", b"An AI-powered meme maestro and blockchain innovator! WALRAI blends the whimsical world of meme coins with the transformative capabilities of AI and the Walrus Protocol on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/WALRAI_72d020da5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

