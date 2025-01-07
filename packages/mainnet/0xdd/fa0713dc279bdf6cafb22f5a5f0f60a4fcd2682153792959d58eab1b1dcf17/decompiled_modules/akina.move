module 0xddfa0713dc279bdf6cafb22f5a5f0f60a4fcd2682153792959d58eab1b1dcf17::akina {
    struct AKINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKINA>(arg0, 6, b"AKINA", b"Akina", b"sui's cutest dog Akina", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/akina_eb5d20720f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

