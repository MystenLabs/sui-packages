module 0x38c4371eca23636044572dd7fcd4ff239dcece6512160fe1940ce525e8bc374d::babycapy {
    struct BABYCAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYCAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYCAPY>(arg0, 9, b"BABYCAPY", b"Baby Capy", b"With their round eyes, soft fur, and clumsy movements, baby capybaras quickly capture the hearts of millions around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/681f9208-2b85-462c-b8e9-db69542ca9e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYCAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYCAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

