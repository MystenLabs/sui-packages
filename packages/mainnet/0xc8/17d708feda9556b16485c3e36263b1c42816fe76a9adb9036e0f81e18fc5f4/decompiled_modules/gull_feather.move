module 0xc817d708feda9556b16485c3e36263b1c42816fe76a9adb9036e0f81e18fc5f4::gull_feather {
    struct GULL_FEATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GULL_FEATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GULL_FEATHER>(arg0, 0, b"GULLFEATHER", b"Gull Feather", x"47756c6c204665617468657220e2809420616e2049646c65205469646573207265736f757263652e204465706f73697420696e2067616d6520746f207573652069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/idle-tides/items/303.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GULL_FEATHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GULL_FEATHER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

