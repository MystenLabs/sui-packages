module 0xc817d708feda9556b16485c3e36263b1c42816fe76a9adb9036e0f81e18fc5f4::harpy_talon {
    struct HARPY_TALON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARPY_TALON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARPY_TALON>(arg0, 0, b"HARPYTALON", b"Harpy Talon", x"48617270792054616c6f6e20e2809420616e2049646c65205469646573207265736f757263652e204465706f73697420696e2067616d6520746f207573652069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/idle-tides/items/306.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HARPY_TALON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARPY_TALON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

