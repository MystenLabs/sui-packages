module 0x3fee1cdded2586a53f40f719686511bdabfdd90c2be1ebbbfec3b5a15a5a124e::mizumeai48 {
    struct MIZUMEAI48 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZUMEAI48, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZUMEAI48>(arg0, 9, b"MizumeAI48", b"Mizume AI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZgQw2tpn12hDteMZ9KrZJg2kvLMSFZrd89N4MPJaPNvN"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIZUMEAI48>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZUMEAI48>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MIZUMEAI48>>(v2);
    }

    // decompiled from Move bytecode v6
}

