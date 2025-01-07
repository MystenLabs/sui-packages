module 0x9a62cc92be6c2bfe172c3bff2847e31200460649d8717398ff87dbb337f26e6c::wsuib {
    struct WSUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUIB>(arg0, 6, b"WSUIB", b"Wall SUI Boys", b"For the boys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/Sv9LEtm.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSUIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WSUIB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WSUIB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

