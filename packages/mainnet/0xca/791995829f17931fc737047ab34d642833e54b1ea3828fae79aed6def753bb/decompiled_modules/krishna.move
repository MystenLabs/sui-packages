module 0xca791995829f17931fc737047ab34d642833e54b1ea3828fae79aed6def753bb::krishna {
    struct KRISHNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRISHNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KRISHNA>(arg0, 6, b"KRISHNA", b"Krishna by SuiAI", b"$KRISHNA is a playful yet spiritually-inspired meme coin that brings ancient wisdom to the crypto space. Based on the beloved Hindu deity known for his divine intelligence, charm, and strategic mindset, $KRISHNA aims to blend cosmic consciousness with crypto culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000004097_7b8447ad6b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRISHNA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRISHNA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

