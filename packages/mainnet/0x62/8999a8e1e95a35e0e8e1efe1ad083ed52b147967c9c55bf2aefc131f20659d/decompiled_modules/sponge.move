module 0x628999a8e1e95a35e0e8e1efe1ad083ed52b147967c9c55bf2aefc131f20659d::sponge {
    struct SPONGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGE>(arg0, 9, b"SPONGE", b"SPONGE on Sui", x"2453504f4e4745207c204a75737420616e6f7468657220676f6f6420646179206f6e200a405375694e6574776f726b0a204f6365616e2e0a2353504f4e47452023535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/df12124be957b5ea727b5289e54d3ff2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPONGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

