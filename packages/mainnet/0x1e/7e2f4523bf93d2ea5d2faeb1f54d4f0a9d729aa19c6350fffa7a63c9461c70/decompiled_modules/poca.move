module 0x1e7e2f4523bf93d2ea5d2faeb1f54d4f0a9d729aa19c6350fffa7a63c9461c70::poca {
    struct POCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCA>(arg0, 6, b"POCA", b"POLAR BEAR", b"Polar who?  Wait... POLAR CAT?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/POCA_7fc916067e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

