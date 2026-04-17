module 0xb43a74674d9dd18ca30ba58d61a24d1b186099261a3253c3dbeccd1b8be2e35e::mysui {
    struct MYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSUI>(arg0, 9, b"SUI", b"Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/lgm1831/sui/main/SUI.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSUI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<MYSUI>>(0x2::coin::mint<MYSUI>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

