module 0xca6a3b72a2e99cf15ff61649c73416f1ff69ca1711b1977cfe616cbc95ca827e::hh {
    struct HH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HH>(arg0, 9, b"HH", b"Hoang", b"Hh1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/068a62ac-3b81-424e-8fd0-6eeacc51056e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HH>>(v1);
    }

    // decompiled from Move bytecode v6
}

