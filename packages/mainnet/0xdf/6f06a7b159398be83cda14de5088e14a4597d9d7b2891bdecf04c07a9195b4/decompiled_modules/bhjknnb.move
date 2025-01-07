module 0xdf6f06a7b159398be83cda14de5088e14a4597d9d7b2891bdecf04c07a9195b4::bhjknnb {
    struct BHJKNNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHJKNNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHJKNNB>(arg0, 9, b"BHJKNNB", b"Pi", b"Pi Network celebrates 2000 days since its official launch on March 14, 2019! This milestone reflects the steady, ongoing efforts of our community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c64935e5-c36a-4f7f-968c-c8be36af97c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHJKNNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BHJKNNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

