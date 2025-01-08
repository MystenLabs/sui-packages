module 0x91243022b2ff3dffbff26702c55356843d5c95e11621a8a9f14221d57f25780d::christ {
    struct CHRIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRIST>(arg0, 9, b"CHRIST", b"Jesus", b"X1000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/390b1827-cb39-4c5d-968b-d4af376900c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRIST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHRIST>>(v1);
    }

    // decompiled from Move bytecode v6
}

