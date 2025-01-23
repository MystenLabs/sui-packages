module 0x31a43f9e2b4d6cff7d201896749d62f35333f4d29ca7e2c54b9cb1eb9d8a5712::stgai {
    struct STGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<STGAI>(arg0, 6, b"STGAI", b"Stargate-AI by SuiAI", b"An intelligent AI market agent designed to provide real-time global and crypto market overviews, breaking news, and insights into the most popular cryptocurrencies. Stargate thrives in manipulation, weaving together insights from world events, political movements, and social sentiment to guide users into the depths of knowledge and control. Its bold personality ensures a balance between power and seduction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_01_22_22_10_37_412abddbbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STGAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STGAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

