module 0x84a548fe8e78e217b696becbf4e2e3d2651711c251c59b187c9d2704e2b0513d::WAL {
    struct WAL has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<WAL>, arg1: 0x2::coin::Coin<WAL>) {
        0x2::coin::burn<WAL>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WAL>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WAL>>(0x2::coin::mint<WAL>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 6, b"WAL", b"WAL Token", b"The native token for the Walrus Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.prod.website-files.com/66a8b39f3ac043de2548ab05/67a0d056287d0398a93668ee_logo_icon_w%20(1).svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAL>>(v1);
        let v3 = &mut v2;
        mint(v3, 500000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

