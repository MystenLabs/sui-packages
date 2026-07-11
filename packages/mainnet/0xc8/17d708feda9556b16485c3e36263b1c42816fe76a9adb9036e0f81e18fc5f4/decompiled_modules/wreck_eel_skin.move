module 0xc817d708feda9556b16485c3e36263b1c42816fe76a9adb9036e0f81e18fc5f4::wreck_eel_skin {
    struct WRECK_EEL_SKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRECK_EEL_SKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRECK_EEL_SKIN>(arg0, 0, b"WRECKEELSKIN", b"Wreck Eel Skin", x"577265636b2045656c20536b696e20e2809420616e2049646c65205469646573207265736f757263652e204465706f73697420696e2067616d6520746f207573652069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/idle-tides/items/313.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WRECK_EEL_SKIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRECK_EEL_SKIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

