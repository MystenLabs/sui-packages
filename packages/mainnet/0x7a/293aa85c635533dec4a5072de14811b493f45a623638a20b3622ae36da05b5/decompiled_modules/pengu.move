module 0x7a293aa85c635533dec4a5072de14811b493f45a623638a20b3622ae36da05b5::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 9, b"PENGU", b"PENGU Penguins", x"537072696e6b6c696e67206a6f79206163726f737320534f4c20f09f90a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmd34wysSXcbS5Q58dub3DdMrPifFiRYVbNtALDpBn9ght")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PENGU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

