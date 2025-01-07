module 0xe7c4434f591924059859f4a262536d4804b17a41c3fb10be440646bdb676a0f9::otomakan {
    struct OTOMAKAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTOMAKAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTOMAKAN>(arg0, 6, b"OTOMAKAN", b"IHSOTAS OTOMAKAN", b"MYSTERIOUS BLUE EYES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/copilot_image_1728479782318_6013971a32.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTOMAKAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTOMAKAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

