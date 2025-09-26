module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::wowok {
    struct WOWOK has drop {
        dummy_field: bool,
    }

    struct ORACLE has store, key {
        id: 0x2::object::UID,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WOWOK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WOWOK>>(0x2::coin::mint<WOWOK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WOWOK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WOWOK>(arg0, 9, b"WOW", b"WoWok", b"https://wowok.net", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wowok.net/icon/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOWOK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWOK>>(v1, v0);
        let v3 = ORACLE{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ORACLE>(v3, v0);
    }

    public fun zero_coin<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::zero<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

