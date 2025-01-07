module 0x4ec2bb6c4cae3d860bb79ad784c60f61b66e3ea7b1a9ed5a68a9fe72e566ed4b::every_love {
    struct EVERY_LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVERY_LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVERY_LOVE>(arg0, 9, b"EVERY_LOVE", b"Love", b"Everyday is Love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2bc564d4-387c-4914-85f4-dd886870e5d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVERY_LOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVERY_LOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

