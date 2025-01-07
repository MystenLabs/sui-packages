module 0x3801eba267988f2cd10786d19375fab81544cf305901387c68d9fa36d0f39824::hopi {
    struct HOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<HOPI>(arg0, 6, b"HOPI", b"HOPIum", x"5468652068696c6172696f75736c7920636c75656c65737320686970706f2077686f20616c77617973206765747320696e746f207269646963756c6f7573206a756e676c65206d6973686170732120f09fa69bf09f92ab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1841398487621251072/pc-TJ8nD_400x400.jpg")), arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPI>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<HOPI>>(v1, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPI>>(v2);
    }

    public fun migrate_to_v1(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<HOPI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<HOPI>(arg0, arg1, arg2, arg3);
    }

    public fun migrate_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<HOPI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<HOPI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

