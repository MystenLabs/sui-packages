module 0xa841a33cd182cfc790f3542b3196e8c7771f02d513b107d2c29c03c01c1f1cc5::smns {
    struct SMNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMNS>(arg0, 9, b"SMNS", b"Simens ", b"Sanek Simens ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/baee726b-af49-4491-94fa-02b58313a0cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

