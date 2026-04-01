module 0xf9b36e7546adb75dd44adf2d763e80af8923e8396e399432a61a6ba58219843a::hsui {
    struct HSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSUI>(arg0, 9, b"hsui", b"hsui Coin", b"hsui Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-testnet.haedal.xyz/htoken/hsui.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

