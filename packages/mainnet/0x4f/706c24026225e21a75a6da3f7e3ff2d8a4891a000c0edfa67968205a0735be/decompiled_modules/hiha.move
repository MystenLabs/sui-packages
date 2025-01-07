module 0x4f706c24026225e21a75a6da3f7e3ff2d8a4891a000c0edfa67968205a0735be::hiha {
    struct HIHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIHA>(arg0, 9, b"HIHA", b"Hihihhaha", b"HihihhahaHihihhaha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ad8449e-24bc-424a-9391-e148a4472b20.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

