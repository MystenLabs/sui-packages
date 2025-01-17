module 0x670638377d254ae1086c2b7c27ab08974be0d29acdca4afc8f78f0ded9b500be::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MEW>(arg0, 6, b"MEW", b"mew by SuiAI", b"mewwwmew.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/3373da1ae6e9a429e7fc8dbad72bf5f4726eb13b_388c253205.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

