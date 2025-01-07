module 0xacc4ace34ef04403fd506b8abc7cdeb42c33178e4a11d11abfa448c4bba45957::pwlnxb {
    struct PWLNXB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWLNXB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWLNXB>(arg0, 9, b"PWLNXB", b"jsjdn", b"bdbdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7da55981-e11f-4fdd-9def-1cd778bde78d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWLNXB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWLNXB>>(v1);
    }

    // decompiled from Move bytecode v6
}

