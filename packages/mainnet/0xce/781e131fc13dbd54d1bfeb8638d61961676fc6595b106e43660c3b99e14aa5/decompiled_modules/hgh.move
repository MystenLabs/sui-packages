module 0xce781e131fc13dbd54d1bfeb8638d61961676fc6595b106e43660c3b99e14aa5::hgh {
    struct HGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HGH>(arg0, 9, b"HGH", b"PASS", b"NINJAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df0deef2-ea7d-4a06-9bfb-803fc3b01a42.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

