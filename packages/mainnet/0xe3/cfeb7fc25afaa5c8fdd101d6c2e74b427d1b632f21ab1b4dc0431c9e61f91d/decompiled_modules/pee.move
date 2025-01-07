module 0xe3cfeb7fc25afaa5c8fdd101d6c2e74b427d1b632f21ab1b4dc0431c9e61f91d::pee {
    struct PEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEE>(arg0, 6, b"PEE", b"PEEPEE", b"PEEE EEEE PEE PEEEEEEEEEEE PEE EPEEEEE!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_09_25_215136_4db917200b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

