module 0x1be9c773ed4e3246de00cc10c54e2b917c80a0c75ca9c4e36a6ba6f3946d3535::planks {
    struct PLANKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANKS>(arg0, 6, b"PLANKS", b"PlanktonSui", b"Alone We're Small. Together We're Giants!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logofix_8898b02c2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLANKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

