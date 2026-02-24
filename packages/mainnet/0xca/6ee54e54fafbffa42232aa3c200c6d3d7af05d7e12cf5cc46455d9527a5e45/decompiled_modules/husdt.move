module 0xca6ee54e54fafbffa42232aa3c200c6d3d7af05d7e12cf5cc46455d9527a5e45::husdt {
    struct HUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSDT>(arg0, 9, b"husdt", b"husdt Coin", b"husdt Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-testnet.haedal.xyz/htoken/husdt.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUSDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

