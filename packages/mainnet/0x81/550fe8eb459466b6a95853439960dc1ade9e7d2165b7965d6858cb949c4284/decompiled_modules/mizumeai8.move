module 0x81550fe8eb459466b6a95853439960dc1ade9e7d2165b7965d6858cb949c4284::mizumeai8 {
    struct MIZUMEAI8 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MIZUMEAI8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZUMEAI8>(arg0, 9, b"MizumeAI8", b"Mizume AI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZgQw2tpn12hDteMZ9KrZJg2kvLMSFZrd89N4MPJaPNvN"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIZUMEAI8>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZUMEAI8>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MIZUMEAI8>>(v2);
    }

    // decompiled from Move bytecode v6
}

