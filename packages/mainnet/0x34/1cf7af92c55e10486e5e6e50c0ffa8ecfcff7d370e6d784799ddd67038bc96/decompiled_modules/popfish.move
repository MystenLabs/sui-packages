module 0x341cf7af92c55e10486e5e6e50c0ffa8ecfcff7d370e6d784799ddd67038bc96::popfish {
    struct POPFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPFISH>(arg0, 6, b"POPFISH", b"Popfish CTO", b"POPFISH CTO POP POP POP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_2_01_636519a6ac.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

