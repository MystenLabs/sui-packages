module 0x7e496cbd630e057da19c9eca511b9178ac9acf674817717bb72365c4b22bb9fa::bchip {
    struct BCHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCHIP>(arg0, 6, b"BCHIP", b"BLUE CHIP", b"Just a Blue Chip spinning and a telegram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009492_6a2582b41a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

