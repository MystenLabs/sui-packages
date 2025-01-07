module 0x35af332d51c711c7f2fd7127e81f323352bfcd6b6fbf00aaa4ba482a3cb0bb33::cpepe {
    struct CPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPEPE>(arg0, 5, b"CPEPE", b"China Pepe", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiagqx6em7jy2kh5mj4ogzh3xfkkgqewid5kw2etfm2bz2slntje6q")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CPEPE>>(v1);
        0x2::coin::mint_and_transfer<CPEPE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPEPE>>(v2, @0x84eb9a768b89104997e0589b0774695550fd4ecd7e67dcbb0cd70282d32e7c1c);
    }

    // decompiled from Move bytecode v6
}

