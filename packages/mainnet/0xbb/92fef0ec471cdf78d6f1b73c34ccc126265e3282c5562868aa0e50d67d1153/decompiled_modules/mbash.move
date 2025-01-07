module 0xbb92fef0ec471cdf78d6f1b73c34ccc126265e3282c5562868aa0e50d67d1153::mbash {
    struct MBASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBASH>(arg0, 9, b"MBASH", b"Bashkan", b"Bashtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d3bedbe-a251-4e96-90bb-3b3b2fb3375c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MBASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

