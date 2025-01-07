module 0x1977493c88ff5f0c69d7e31db4c4209a78c230f6c06519d9f58d8a1764a3035e::tmss {
    struct TMSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMSS>(arg0, 9, b"TMSS", b"Tomas Shelby", b"G", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"WW")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TMSS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMSS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

