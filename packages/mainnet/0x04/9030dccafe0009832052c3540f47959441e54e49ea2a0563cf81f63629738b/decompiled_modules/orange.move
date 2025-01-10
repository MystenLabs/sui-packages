module 0x49030dccafe0009832052c3540f47959441e54e49ea2a0563cf81f63629738b::orange {
    struct ORANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORANGE>(arg0, 6, b"ORANGE", b"OrangeBot App", b"With $ORANGE, enhance your community engagement on the Sui Network using the power of automation and advanced tools.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736519440456.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORANGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

