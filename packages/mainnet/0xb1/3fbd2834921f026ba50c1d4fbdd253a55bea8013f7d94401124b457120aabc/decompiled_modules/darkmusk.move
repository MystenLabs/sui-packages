module 0xb13fbd2834921f026ba50c1d4fbdd253a55bea8013f7d94401124b457120aabc::darkmusk {
    struct DARKMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARKMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARKMUSK>(arg0, 6, b"DarkMusk", b"Dark Musk", b"The first one an only on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2456_97d7a21fab.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARKMUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARKMUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

