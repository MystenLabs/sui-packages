module 0xecb06b26f02cbede437ca878f87524882588010e9bebaeea3751d0579063135::dfhdfs {
    struct DFHDFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFHDFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFHDFS>(arg0, 9, b"DFHDFS", b"KJHHDF", b"BBCHDF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d16b976d-e173-4343-953a-7e77fc2ef346.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFHDFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFHDFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

