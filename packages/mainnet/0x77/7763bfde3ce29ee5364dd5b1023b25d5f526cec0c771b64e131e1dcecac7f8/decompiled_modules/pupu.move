module 0x777763bfde3ce29ee5364dd5b1023b25d5f526cec0c771b64e131e1dcecac7f8::pupu {
    struct PUPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPU>(arg0, 9, b"PUPU", b"Pupu", b"Pupu To The Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e0f6fe8-bce7-492c-8319-8d33e3143308.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

