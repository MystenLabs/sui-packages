module 0xa24afe3f774f1f291dd8d74729079ee09871e49cf4417cf9983966a9d3d71d70::ptoshi {
    struct PTOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTOSHI>(arg0, 9, b"PTOSHI", b"IamSatoshi", b"Forbes just confirmed that HBO's documentary is saying Peter Todd is Satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/edf04b52-1128-4a3b-86af-8766e306fc7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

