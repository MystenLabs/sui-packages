module 0x1676d7b6b4dae2a5963a0a7bc406d1d1b33d3e6bedf7f37931cd6eadbf22220c::pkm {
    struct PKM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://beardsley.librarycalendar.com/sites/default/files/styles/lc_featured_image/public/2023-09/Pokemon-PNG_1.png";
        let v1 = if (0x1::vector::is_empty<u8>(&v0)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"{{ICON_URL}}"))
        };
        let (v2, v3) = 0x2::coin::create_currency<PKM>(arg0, 9, b"PKM", b"POKEMON", x"5465656e20416e696d6520436c7562212028504f4bc3894d4f4e2129", v1, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKM>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKM>>(v3);
    }

    // decompiled from Move bytecode v7
}

