module 0x7df01c1fc3f6623c83686a35e3c947f2ecb46dffde1cc76606b6a01af8416ee9::mpt {
    struct MPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPT>(arg0, 9, b"MPT", b"Mpt ", x"53c6a16e2074c3b96e67204d5054", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8319382-fe87-406e-9fe4-c8586c268bbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

