module 0xa1b78641cebf0d763433e1fcf34a9cbd5332d4e55b086abfacf4a8d736541e3e::iykyk {
    struct IYKYK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IYKYK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IYKYK>(arg0, 9, b"IYKYK", b"IYKYK", b"IF You Know You Know", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IYKYK>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IYKYK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IYKYK>>(v1);
    }

    // decompiled from Move bytecode v6
}

