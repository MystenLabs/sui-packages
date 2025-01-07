module 0xf63a55056e5047f6a124dd1cad09e7d2014c8ae0c14a0f5f9619d0f242584a51::dwil {
    struct DWIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWIL>(arg0, 6, b"Dwil", b"Dogwilamb", b"Loading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3478_9c9fcfe676.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

