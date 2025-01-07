module 0x2656a365094b9841992cb327db2113c4b95c8940f8fe9ee1d93fa645d31afb0::zuzy {
    struct ZUZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUZY>(arg0, 9, b"ZUZY", b"Zuzu", b"Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf10e7c2-ad12-4a00-82d8-c04ea0d4efc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

