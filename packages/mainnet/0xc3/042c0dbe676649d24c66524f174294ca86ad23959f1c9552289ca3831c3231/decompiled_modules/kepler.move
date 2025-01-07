module 0xc3042c0dbe676649d24c66524f174294ca86ad23959f1c9552289ca3831c3231::kepler {
    struct KEPLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEPLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEPLER>(arg0, 9, b"KEPLER", b"KEPLER", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KEPLER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEPLER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEPLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

