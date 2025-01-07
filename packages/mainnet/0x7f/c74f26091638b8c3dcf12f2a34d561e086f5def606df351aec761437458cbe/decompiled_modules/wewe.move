module 0x7fc74f26091638b8c3dcf12f2a34d561e086f5def606df351aec761437458cbe::wewe {
    struct WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWE>(arg0, 6, b"WEWE", b"WEWEonsui", x"4d656d6520636f696e20637265617465642062792074686520576176652054726164696e6720636f6d6d756e697479206f6e200a405375694e6574776f726b0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731501829486.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

