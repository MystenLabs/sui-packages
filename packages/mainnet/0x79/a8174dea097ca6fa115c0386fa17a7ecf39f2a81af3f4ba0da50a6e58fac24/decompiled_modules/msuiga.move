module 0x79a8174dea097ca6fa115c0386fa17a7ecf39f2a81af3f4ba0da50a6e58fac24::msuiga {
    struct MSUIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSUIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSUIGA>(arg0, 6, b"MSUIGA", b"MAKE SUI GREAT AGAIN", x"4974206973206d792073746f7279203a204920616d206120646965206861726420535549206c6f7665722c20796573206265636175736520697420697320535549207768696368206368616e676564206d79206c6966652e202049742069732061206d697373696f6e20746f206d616b652053554920677265617420616761696e2e20205965732c20746f6765746865722077652063616e2e2020244d53554947410a0a4a6f696e2054656c656772616d203a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1778335543442.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSUIGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSUIGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

