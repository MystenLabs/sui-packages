module 0xef2c982c10b5346e5ce1c498ebcd99f39bcc807ab5f93bda72ff9815b1c2f3c::w123456789 {
    struct W123456789 has drop {
        dummy_field: bool,
    }

    fun init(arg0: W123456789, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W123456789>(arg0, 9, b"W123456789", b"AAA", b"H-andsomeboy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11e10c2d-4741-4f7e-952c-efa2b13b6c1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W123456789>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<W123456789>>(v1);
    }

    // decompiled from Move bytecode v6
}

