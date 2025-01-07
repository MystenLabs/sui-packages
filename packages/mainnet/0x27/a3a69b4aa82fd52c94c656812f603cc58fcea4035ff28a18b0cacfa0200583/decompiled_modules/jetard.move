module 0x27a3a69b4aa82fd52c94c656812f603cc58fcea4035ff28a18b0cacfa0200583::jetard {
    struct JETARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: JETARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JETARD>(arg0, 6, b"JETARD", b"Jellyfish retard", b"Now its MY turn to catch a N*gg*", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/85e2b4f7bc75cebd51dff9d9aa3bc325_453688b72c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JETARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JETARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

