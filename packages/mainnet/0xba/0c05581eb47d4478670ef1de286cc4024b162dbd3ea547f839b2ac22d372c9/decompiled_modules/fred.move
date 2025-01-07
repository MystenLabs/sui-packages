module 0xba0c05581eb47d4478670ef1de286cc4024b162dbd3ea547f839b2ac22d372c9::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRED>(arg0, 9, b"FRED", b"Sui Fred", x"244652454420f09f9a80204578706572696d656e7420746f206d616b65207468652062657374206d656d65636f696e206f6e2053756920636861696e2e2246726f6d206e6f77206f6e2c206c657427732069676e697465207468652053706f6e6765426f62206d65746176657273652e2220492077616e7420746f206865616c206d79206c65672e20f09fa6b54f48204d59204c454720f09fa6b5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmQtRLqXv98x3dzZEM3iw15zKqjcKypCrTU4aujJmh8XLT?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FRED>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRED>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

