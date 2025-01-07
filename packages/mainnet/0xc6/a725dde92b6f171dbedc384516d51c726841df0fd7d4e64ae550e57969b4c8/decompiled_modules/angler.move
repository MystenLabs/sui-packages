module 0xc6a725dde92b6f171dbedc384516d51c726841df0fd7d4e64ae550e57969b4c8::angler {
    struct ANGLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGLER>(arg0, 6, b"ANGLER", b"ANGLERFISH", b"The most viscous fish predator of the deep dark seas came to light on SUI. This will eat all your weak fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240916_122727_f9ced6ecc2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

