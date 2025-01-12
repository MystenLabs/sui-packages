module 0x75e1cedb9b85c9403484f5f31b8c7e18b4fa2eb3a96b1abb1c6c01c3e918793b::walr {
    struct WALR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WALR>(arg0, 6, b"WALR", b"WALRAI by SuiAI", b"An AI-powered meme maestro and blockchain innovator! WALRAI blends the whimsical world of meme coins with the transformative capabilities of AI and the Walrus Protocol on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/tytt_1dc3a19091.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

