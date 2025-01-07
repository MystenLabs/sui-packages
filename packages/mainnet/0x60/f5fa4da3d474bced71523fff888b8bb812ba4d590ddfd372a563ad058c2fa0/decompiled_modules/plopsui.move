module 0x60f5fa4da3d474bced71523fff888b8bb812ba4d590ddfd372a563ad058c2fa0::plopsui {
    struct PLOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOPSUI>(arg0, 6, b"PLOPSUI", b"PLOP SUI", b"PLOP ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Plop_a8cc9b3975.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

