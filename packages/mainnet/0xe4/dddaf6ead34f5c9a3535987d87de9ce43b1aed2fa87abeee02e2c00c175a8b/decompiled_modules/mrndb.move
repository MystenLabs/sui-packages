module 0xe4dddaf6ead34f5c9a3535987d87de9ce43b1aed2fa87abeee02e2c00c175a8b::mrndb {
    struct MRNDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRNDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRNDB>(arg0, 9, b"MRNDB", b"uejeb", b"heisj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/57af2988-18a6-4b06-8186-1a6a8a3ee7cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRNDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRNDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

