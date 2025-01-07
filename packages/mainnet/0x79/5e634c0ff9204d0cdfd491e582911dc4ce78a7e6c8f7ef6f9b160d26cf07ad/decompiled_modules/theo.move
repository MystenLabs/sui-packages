module 0x795e634c0ff9204d0cdfd491e582911dc4ce78a7e6c8f7ef6f9b160d26cf07ad::theo {
    struct THEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEO>(arg0, 9, b"THEO", b"Theodore", b"Theo of web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f33fe83-ba88-4e2d-9f13-12e244b55a1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

