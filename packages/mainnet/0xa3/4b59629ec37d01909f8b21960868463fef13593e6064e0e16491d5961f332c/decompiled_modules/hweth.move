module 0xa34b59629ec37d01909f8b21960868463fef13593e6064e0e16491d5961f332c::hweth {
    struct HWETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HWETH>(arg0, 8, b"hweth", b"hweth Coin", b"hweth Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"/images/eth-logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HWETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWETH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

