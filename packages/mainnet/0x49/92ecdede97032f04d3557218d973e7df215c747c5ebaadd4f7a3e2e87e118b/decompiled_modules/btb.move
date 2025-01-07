module 0x4992ecdede97032f04d3557218d973e7df215c747c5ebaadd4f7a3e2e87e118b::btb {
    struct BTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTB>(arg0, 6, b"BTB", b"Blub The Blub", b"In your home have Blub and fishblub sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037448_6ccff8e5e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTB>>(v1);
    }

    // decompiled from Move bytecode v6
}

