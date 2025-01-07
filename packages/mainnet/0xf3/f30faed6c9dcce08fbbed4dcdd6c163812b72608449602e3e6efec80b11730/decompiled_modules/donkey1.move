module 0xf3f30faed6c9dcce08fbbed4dcdd6c163812b72608449602e3e6efec80b11730::donkey1 {
    struct DONKEY1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKEY1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKEY1>(arg0, 9, b"DONKEY1", b"Donkey ", b"For you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/466c671c-a511-41e3-a671-221173eadd94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKEY1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONKEY1>>(v1);
    }

    // decompiled from Move bytecode v6
}

