module 0xdf062173857d39dcc3959ff73d973f6d2eca3d0012b819bf24dc9b6b467e8d75::primecoin {
    struct PRIMECOIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PRIMECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIMECOIN>>(0x2::coin::mint<PRIMECOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PRIMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMECOIN>(arg0, 6, b"PRIME", b"PrimeCoin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://icons.iconarchive.com/icons/microsoft/fluentui-emoji-3d/128/Money-Bag-3d-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIMECOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIMECOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

