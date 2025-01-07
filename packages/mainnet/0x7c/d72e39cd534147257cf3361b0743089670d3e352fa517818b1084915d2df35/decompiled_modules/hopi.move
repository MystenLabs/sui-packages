module 0x7cd72e39cd534147257cf3361b0743089670d3e352fa517818b1084915d2df35::hopi {
    struct HOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPI>(arg0, 6, b"HOPI", b"Hopi", x"5468652068696c6172696f75736c7920636c75656c65737320686970706f2077686f20616c77617973206765747320696e746f207269646963756c6f7573206a756e676c65206d6973686170732120f09fa69bf09f92ab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958306745.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

