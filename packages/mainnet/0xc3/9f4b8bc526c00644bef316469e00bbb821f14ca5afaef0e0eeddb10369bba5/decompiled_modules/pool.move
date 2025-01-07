module 0xc39f4b8bc526c00644bef316469e00bbb821f14ca5afaef0e0eeddb10369bba5::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOL>(arg0, 6, b"POOL", b"Pool Suirty", x"5468697320626c75652077617465722064726f706c65742069736ee2809974206a75737420612063757465206d656d6520e28094206974206861732061206d697373696f6e3a20746f2072656d696e642065766572796f6e6520686f7720657373656e7469616c20776174657220697320746f2068756d616e206c69666520616e6420686f7720696d706f7274616e7420697420697320746f2070726f7465637420746869732070726563696f7573207265736f757263652120f09f8c8df09f9ab0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730986973517.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

