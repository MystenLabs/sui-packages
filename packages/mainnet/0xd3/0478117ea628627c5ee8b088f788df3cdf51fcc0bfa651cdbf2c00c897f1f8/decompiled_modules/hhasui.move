module 0xd30478117ea628627c5ee8b088f788df3cdf51fcc0bfa651cdbf2c00c897f1f8::hhasui {
    struct HHASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHASUI>(arg0, 9, b"hhasui", b"hhasui Coin", b"hhasui Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-testnet.haedal.xyz/htoken/hhasui.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

