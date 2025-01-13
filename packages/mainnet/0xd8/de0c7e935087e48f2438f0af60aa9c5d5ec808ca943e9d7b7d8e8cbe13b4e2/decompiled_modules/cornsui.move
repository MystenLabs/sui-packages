module 0xd8de0c7e935087e48f2438f0af60aa9c5d5ec808ca943e9d7b7d8e8cbe13b4e2::cornsui {
    struct CORNSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORNSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORNSUI>(arg0, 6, b"CORNSUI", b"Corn and sui", b"Its just a sweet corn on SUI. :D", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250113_072922_344_8259d83152.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORNSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORNSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

