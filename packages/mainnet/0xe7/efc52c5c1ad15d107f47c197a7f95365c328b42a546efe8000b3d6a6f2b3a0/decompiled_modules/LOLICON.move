module 0xe7efc52c5c1ad15d107f47c197a7f95365c328b42a546efe8000b3d6a6f2b3a0::LOLICON {
    struct LOLICON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOLICON>, arg1: 0x2::coin::Coin<LOLICON>) {
        0x2::coin::burn<LOLICON>(arg0, arg1);
    }

    fun init(arg0: LOLICON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLICON>(arg0, 9, b"LOLI", b"LOLICON", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/d4LTDd3/lolicon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLICON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLICON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOLICON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LOLICON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

