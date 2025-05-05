module 0x961a688c1ef46d32b3793ffd562d7ef7dec2ee68080a8f3e379b0bb68a60d1a6::wale {
    struct WALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALE>(arg0, 9, b"WALE", b"Wale", b"Wale making wave on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WALE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

