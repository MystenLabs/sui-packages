module 0x7d70468bad26673beabc573b65b78dc392f4dcb5ffa603c091d1fc6ddaa3e8bc::kerbi {
    struct KERBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERBI>(arg0, 6, b"Kerbi", b"Knockoff Kirby", b"Kerbi/Knockoff Kirby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_03_13_181019_951202a8ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KERBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

