module 0x541fa531924dd601b8d3b8da14e96a6ce3bdea6e7bd3833f1ee09ecb3565480::mk {
    struct MK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MK>(arg0, 9, b"MK", b"Manoj", b"Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e72705cb-741e-49a6-8a16-7a788a4c4b5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MK>>(v1);
    }

    // decompiled from Move bytecode v6
}

