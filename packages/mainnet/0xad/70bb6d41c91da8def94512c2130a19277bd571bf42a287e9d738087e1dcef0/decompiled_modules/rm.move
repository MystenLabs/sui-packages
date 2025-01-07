module 0xad70bb6d41c91da8def94512c2130a19277bd571bf42a287e9d738087e1dcef0::rm {
    struct RM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RM>(arg0, 6, b"RM", b"Madrista by SuiAI", b"Just to support the king of football ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6241_ba0e4fc070.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

