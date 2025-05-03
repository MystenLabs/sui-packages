module 0xae135ef8d3ecd2db488a14db455718e00c64789cbd7a8be446e193a2ec1a20b4::yoshi {
    struct YOSHI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YOSHI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x171e71f00cc302ae1732a79ca6d2ca686c243c1dd304c4d3279cc6b512050aa, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<YOSHI>>(0x2::coin::mint<YOSHI>(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: YOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOSHI>(arg0, 9, b"YOSHI", b"Yoshi Inu", b"Yoshi Inu hopping on SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/C51S46T0/YOSHI.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOSHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

