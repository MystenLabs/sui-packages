module 0xed9f244699737a9f22943528db1197f4a946d41f4185e3884b1e8f988c8cc822::lolasui {
    struct LOLASUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOLASUI>, arg1: 0x2::coin::Coin<LOLASUI>) {
        0x2::coin::burn<LOLASUI>(arg0, arg1);
    }

    fun init(arg0: LOLASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLASUI>(arg0, 9, b"lola sui", b"lui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/QAhSnzG.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLASUI>>(v1);
        0x2::coin::mint_and_transfer<LOLASUI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLASUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOLASUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LOLASUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

