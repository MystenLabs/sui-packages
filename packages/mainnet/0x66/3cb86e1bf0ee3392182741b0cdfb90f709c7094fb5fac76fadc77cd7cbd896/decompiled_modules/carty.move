module 0x663cb86e1bf0ee3392182741b0cdfb90f709c7094fb5fac76fadc77cd7cbd896::carty {
    struct CARTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTY>(arg0, 9, b"CARTY", b"CARTY", b"CARTY Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CARTY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

