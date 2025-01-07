module 0xd90cb3d9dc56284cef57ce28c7107f34dd9f653a278869411d8b53b10e2daee4::onlyone {
    struct ONLYONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONLYONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONLYONE>(arg0, 9, b"ONLYONE", b"Only one", b"Only one for you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6ebb7e0-0b0b-45b1-8b86-9e5cd97542b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONLYONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONLYONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

