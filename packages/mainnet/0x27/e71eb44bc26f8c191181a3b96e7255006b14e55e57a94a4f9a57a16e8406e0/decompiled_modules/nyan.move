module 0x27e71eb44bc26f8c191181a3b96e7255006b14e55e57a94a4f9a57a16e8406e0::nyan {
    struct NYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NYAN>(arg0, 6, b"NYAN", b"Nyan", b"@suilaunchcoin $NYAN + Nyan Cat https://t.co/kGcTpYGpph", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/nyan-hvrmk8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NYAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

