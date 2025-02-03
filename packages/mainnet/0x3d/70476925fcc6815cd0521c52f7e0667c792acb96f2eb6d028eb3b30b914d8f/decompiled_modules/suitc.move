module 0x3d70476925fcc6815cd0521c52f7e0667c792acb96f2eb6d028eb3b30b914d8f::suitc {
    struct SUITC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITC>(arg0, 9, b"SUITC", b"Sui Test Coin", b"Coin for testing creation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITC>(&mut v2, 2200000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITC>>(v1);
    }

    // decompiled from Move bytecode v6
}

