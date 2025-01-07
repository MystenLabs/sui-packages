module 0xa0cd33e676f45ebe0bb94c2959f631c02d505bde050f35a429f97d2f70f95b25::dao {
    struct DAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAO>(arg0, 9, b"DAO", b"xDao", b"Just fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e35f7bc6-9ad0-497a-819f-89619cfe1786.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

