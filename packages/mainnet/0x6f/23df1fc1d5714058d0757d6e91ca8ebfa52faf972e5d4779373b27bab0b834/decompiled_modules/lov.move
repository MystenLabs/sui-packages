module 0x6f23df1fc1d5714058d0757d6e91ca8ebfa52faf972e5d4779373b27bab0b834::lov {
    struct LOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOV>(arg0, 9, b"LOV", b"Love", b"Love musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f052c2d1-5c29-4706-87c7-e01ed7abf71d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOV>>(v1);
    }

    // decompiled from Move bytecode v6
}

