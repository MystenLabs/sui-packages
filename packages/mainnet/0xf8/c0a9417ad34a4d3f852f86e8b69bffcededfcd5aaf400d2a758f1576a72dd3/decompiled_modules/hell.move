module 0xf8c0a9417ad34a4d3f852f86e8b69bffcededfcd5aaf400d2a758f1576a72dd3::hell {
    struct HELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELL>(arg0, 9, b"HELL", b"Hello", b"Hello bae", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d268608-78b1-487d-9c38-6cf8e3f73184.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

