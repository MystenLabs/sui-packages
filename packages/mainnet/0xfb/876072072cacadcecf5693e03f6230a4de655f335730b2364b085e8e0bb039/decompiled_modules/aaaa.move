module 0xfb876072072cacadcecf5693e03f6230a4de655f335730b2364b085e8e0bb039::aaaa {
    struct AAAA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AAAA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AAAA>>(0x2::coin::mint<AAAA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAA>(arg0, 6, b"AAAA", b"AAAA", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAA>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAAA>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

