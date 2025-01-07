module 0x43d09f620bde18a17ba568fb13ccb675fc0066dbe31500391465270e02ece817::mx {
    struct MX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MX>(arg0, 9, b"MX", b"Matrix", b"THIS IS FOR RICH PEOPLE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6cce83ef-9302-43e8-895c-c8c6c0f4b9b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MX>>(v1);
    }

    // decompiled from Move bytecode v6
}

