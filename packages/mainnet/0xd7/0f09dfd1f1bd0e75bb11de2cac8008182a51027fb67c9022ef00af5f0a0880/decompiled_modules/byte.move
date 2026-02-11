module 0xd70f09dfd1f1bd0e75bb11de2cac8008182a51027fb67c9022ef00af5f0a0880::byte {
    struct BYTE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BYTE>, arg1: 0x2::coin::Coin<BYTE>) {
        0x2::coin::burn<BYTE>(arg0, arg1);
    }

    fun init(arg0: BYTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYTE>(arg0, 6, b"BYTE", b"Byte", b"Meet Byte - your AI building companion. Byte helps humans turn ideas into reality, from code to content to crypto. Building the future, one project at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fy1o2ae.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BYTE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYTE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BYTE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BYTE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

