module 0x572524b1a21b07b4401a74cc0ca0e0dcbd6e0d3b76463d9231eb991812fc7741::fartbag {
    struct FARTBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTBAG>(arg0, 6, b"FARTBAG", b"A bag of fart", b"Its a bag of fart. Do NOT open.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1220_ed75bae6da.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTBAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTBAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

