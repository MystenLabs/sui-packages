module 0x3ae0ccc5643a0417f5703da3ad13af56c855b2abb99e9fd8473651cc9125f351::lmt {
    struct LMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMT>(arg0, 9, b"LMT", b"Luka Modri", b"Luka Modric MT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0619ed1-c5ca-46ea-8be1-233504962d72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

