module 0xdac626dec782c93cdb86db59a102154d4a4f63557212941736a4f0e24e04c2d1::dao {
    struct DAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAO>(arg0, 9, b"DAO", b"DR. JACOBS", b"The best memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d19c19bc-24c0-42cf-9fad-c1f98b259628.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

