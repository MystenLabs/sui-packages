module 0xf40b1a367f859191391b4f231e9469e8741a299a4af13f39c06e1bffe0dcf5cd::anon {
    struct ANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANON>(arg0, 9, b"ANON", b"ANON", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.suipump.org/icons/c5d7956f7f579cee84146fedc27e35a6.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ANON>>(0x2::coin::mint<ANON>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANON>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

