module 0x71fad4eb2b30b867b38c729553345821f8c51670a44bc4046fa998a3bab87909::bebw {
    struct BEBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBW>(arg0, 9, b"BEBW", b"Bebe wif ", b"A Bebe wif Hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86dc473e-0c5f-4363-8ee4-f599bb67a4d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBW>>(v1);
    }

    // decompiled from Move bytecode v6
}

