module 0xde01f8e1e2cad6bb05c297168a618fc924ef78c67fa57e2af686be061738ad09::jok {
    struct JOK has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JOK>>(0x2::coin::mint<JOK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOK>(arg0, 8, b"JOK", b"JOK", b"This is JOK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/88609838?s=96&v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

