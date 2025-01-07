module 0x1d533ae500369043617b26f2c0d7ae7281260818876c0a9bdca7253ab7bde3ca::rr {
    struct RR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RR>(arg0, 9, b"RR", b"Raor", b"Roar angry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7aa24e9f-1611-41bb-a4cd-7a1451ae8a21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RR>>(v1);
    }

    // decompiled from Move bytecode v6
}

