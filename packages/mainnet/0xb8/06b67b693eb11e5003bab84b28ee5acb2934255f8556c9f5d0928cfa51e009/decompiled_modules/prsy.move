module 0xb806b67b693eb11e5003bab84b28ee5acb2934255f8556c9f5d0928cfa51e009::prsy {
    struct PRSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRSY>(arg0, 9, b"PRSY", b"Precious ", b"Precious coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/633b25de-f671-472c-9ba1-fc22c43a1f18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

