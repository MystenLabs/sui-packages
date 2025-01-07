module 0xbfc504eae078ac17f97073354fa76feab9ea5d244344cae08b515515d9087ff2::yar {
    struct YAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAR>(arg0, 9, b"YAR", b"Yaro", b"Community Token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe48dc80-7c9a-4a4d-938c-59bcada6239a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

