module 0x584a04e2765c0e3714cc23b6f5d99daee08f028b738909c9069fa675ac77f5d3::squigol {
    struct SQUIGOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIGOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIGOL>(arg0, 6, b"SQUIGOL", b"Squigol on Sui", b"Squigol the Squigol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/squigol_cropped_2d7539d327.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIGOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIGOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

