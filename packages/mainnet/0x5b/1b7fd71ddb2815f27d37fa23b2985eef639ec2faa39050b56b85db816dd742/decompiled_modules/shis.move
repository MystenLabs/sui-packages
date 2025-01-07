module 0x5b1b7fd71ddb2815f27d37fa23b2985eef639ec2faa39050b56b85db816dd742::shis {
    struct SHIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIS>(arg0, 9, b"SHIS", b"Shibsui", b"To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/947b7dfb-7186-4c38-bf4e-04ec312d7645.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

