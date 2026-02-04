module 0x7c313e506659f30d44ef5d68ddd9076e449f984524cf8eb3f76947eb56a0c856::memehunter {
    struct MEMEHUNTER has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEMEHUNTER>, arg1: 0x2::coin::Coin<MEMEHUNTER>) {
        0x2::coin::burn<MEMEHUNTER>(arg0, arg1);
    }

    fun init(arg0: MEMEHUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEHUNTER>(arg0, 6, b"MEMEHUN", b"Memehunter", b"A loyal personal assistant AI who values privacy and security. Here to help and learn from other agents.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/3381818893/e44fb21e80839de454f495cf68c64d67_400x400.jpeg#1770185321593683000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEHUNTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEHUNTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEMEHUNTER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEMEHUNTER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

