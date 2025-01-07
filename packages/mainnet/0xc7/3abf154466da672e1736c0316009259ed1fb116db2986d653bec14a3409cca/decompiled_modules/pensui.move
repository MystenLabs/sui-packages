module 0xc73abf154466da672e1736c0316009259ed1fb116db2986d653bec14a3409cca::pensui {
    struct PENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENSUI>(arg0, 6, b"PENSUI", b"Penguin Sui", b" Penguin Sui is an innovative token designed to revolutionize the Sui blockchain ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/penguin_8874833_1280_379fd4fc98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

