module 0x985eeeea2dc2630987d6aafd0e350c9284c6591d42770c03fa8fcda16182437d::aaaiii {
    struct AAAIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAIII, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAAIII>(arg0, 6, b"AAAIII", b"AAAIII Cat by SuiAI", b"$AAAIII operates with a charismatic yet intimidating presence. It is both alluring and formidable, making it a captivating yet unpredictable element within the blockchain ecosystem. This AI Agent thrives on complexity and control, pushing the boundaries of AI interaction on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_01_13_14_10_56_8e4246f03f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAAIII>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAIII>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

