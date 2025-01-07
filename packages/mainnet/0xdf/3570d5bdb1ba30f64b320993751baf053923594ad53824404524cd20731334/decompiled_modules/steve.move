module 0xdf3570d5bdb1ba30f64b320993751baf053923594ad53824404524cd20731334::steve {
    struct STEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEVE>(arg0, 6, b"STEVE", b"STEVE on Sui", x"24535445564520697320746865206e65696768626f72686f6f642064727567206465616c6572206f662053554920636861696e2c206261736564206f6e2061206368617261637465722066726f6d204d617474204675726965277320426f79277320436c756220436f6d69632e0a28546869732070726f6a65637420697320666f722074686520636f6d6d756e69747929", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735996850309.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

