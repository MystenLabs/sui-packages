module 0x9a00f8a060dc3596c5b62e03d3217066ebd57ba9801ebe11a4c1a42dd9132505::bum {
    struct BUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUM>(arg0, 9, b"BUM", b"Sun", b"Very", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c058abb-008b-4f8c-8cd9-2b9eb9a62276.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

