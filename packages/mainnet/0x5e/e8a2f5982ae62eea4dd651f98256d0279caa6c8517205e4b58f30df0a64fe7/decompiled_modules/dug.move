module 0x5ee8a2f5982ae62eea4dd651f98256d0279caa6c8517205e4b58f30df0a64fe7::dug {
    struct DUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUG>(arg0, 9, b"DUG", b"DUMBGIRL", b"DUMB GIRL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/405a9ac9-8679-41de-a68e-58f5a08d1213.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

