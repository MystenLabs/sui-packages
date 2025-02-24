module 0x22e8e3e017b5ca82c836e55e181148f4f005b3081b8e4d6d64ad1b7cf9f18e7b::huywewe {
    struct HUYWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUYWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUYWEWE>(arg0, 9, b"HUYWEWE", b"Truonghuy9", b"Hello", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b3a3d45-cd11-4be1-83ea-9d4085a9adf6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUYWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUYWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

