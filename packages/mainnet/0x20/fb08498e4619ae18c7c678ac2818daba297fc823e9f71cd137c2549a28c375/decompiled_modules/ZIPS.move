module 0x20fb08498e4619ae18c7c678ac2818daba297fc823e9f71cd137c2549a28c375::ZIPS {
    struct ZIPS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZIPS>, arg1: 0x2::coin::Coin<ZIPS>) {
        0x2::coin::burn<ZIPS>(arg0, arg1);
    }

    fun init(arg0: ZIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIPS>(arg0, 9, b"ZIPS", b"ZIPS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/qNZwRMZ/zips.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZIPS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZIPS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

