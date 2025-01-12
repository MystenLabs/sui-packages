module 0x90638cfc079f55b1035708f35908bd9cdf53d3ebf4b073ce91dcd30a4981b4::orange {
    struct ORANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ORANGE>(arg0, 6, b"ORANGE", b"OrangeBot App by SuiAI", b"With $ORANGE, enhance your community engagement on the Sui Network using the power of automation and advanced tools.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ggfdgf_eee241d7df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORANGE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANGE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

