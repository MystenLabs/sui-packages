module 0xba96b4f47b8b6723580d6648d5ca6bb57d8ba4a5da960387af0ef9e72466bdc::dao {
    struct DAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAO>(arg0, 9, b"DAO", b"xDao", b"Just fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a97105e-7f58-4e85-bd15-6eb6592c2085.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

