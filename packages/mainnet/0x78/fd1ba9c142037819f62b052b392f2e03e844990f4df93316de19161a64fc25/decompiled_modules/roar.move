module 0x78fd1ba9c142037819f62b052b392f2e03e844990f4df93316de19161a64fc25::roar {
    struct ROAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROAR>(arg0, 9, b"ROAR", b"Roar kong", b"Roarkong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1054e3c1-5f21-43e0-99cb-70f51a2f5a64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

