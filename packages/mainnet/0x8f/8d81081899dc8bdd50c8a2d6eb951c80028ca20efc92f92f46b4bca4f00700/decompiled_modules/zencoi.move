module 0x8f8d81081899dc8bdd50c8a2d6eb951c80028ca20efc92f92f46b4bca4f00700::zencoi {
    struct ZENCOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENCOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZENCOI>(arg0, 9, b"ZENCOI", b"ZENCOIN", b"Zencoi number one ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9031aeb0-cf16-48d1-8e6c-f07d35a8abbb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENCOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZENCOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

