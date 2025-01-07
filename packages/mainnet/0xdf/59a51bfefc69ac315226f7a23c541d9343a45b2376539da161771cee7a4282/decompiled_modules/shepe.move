module 0xdf59a51bfefc69ac315226f7a23c541d9343a45b2376539da161771cee7a4282::shepe {
    struct SHEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEPE>(arg0, 6, b"SHEPE", b"Shark Pepe", b"The OG has been reborn on SUI as a shark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0277_a033fc89fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

