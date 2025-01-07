module 0x149b684bb8061e690fe2e7e5d99d2eda20f7171f773c2cc27d6206e54c765785::toki {
    struct TOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKI>(arg0, 9, b"Toki", b"Toki", b"Toko The tokin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKI>(&mut v2, 90000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

