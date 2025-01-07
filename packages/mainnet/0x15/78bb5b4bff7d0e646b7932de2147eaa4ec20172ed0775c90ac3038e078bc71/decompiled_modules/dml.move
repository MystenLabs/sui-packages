module 0x1578bb5b4bff7d0e646b7932de2147eaa4ec20172ed0775c90ac3038e078bc71::dml {
    struct DML has drop {
        dummy_field: bool,
    }

    fun init(arg0: DML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DML>(arg0, 9, b"DML", b"Dhamal", b"Dhamal is native meme coin on sui blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/231bf4d4-cfa9-4b34-a611-07a81efbbfc3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DML>>(v1);
    }

    // decompiled from Move bytecode v6
}

