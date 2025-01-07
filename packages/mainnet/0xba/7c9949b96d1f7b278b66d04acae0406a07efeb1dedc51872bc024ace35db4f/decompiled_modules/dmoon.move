module 0xba7c9949b96d1f7b278b66d04acae0406a07efeb1dedc51872bc024ace35db4f::dmoon {
    struct DMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMOON>(arg0, 9, b"DMOON", b"DOGMOON", b"DOGMOON LIVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5096650d-7a64-40d1-9ce3-98db9c53109a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

