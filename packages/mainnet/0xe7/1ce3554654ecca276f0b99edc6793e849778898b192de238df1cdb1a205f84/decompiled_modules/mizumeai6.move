module 0xe71ce3554654ecca276f0b99edc6793e849778898b192de238df1cdb1a205f84::mizumeai6 {
    struct MIZUMEAI6 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MIZUMEAI6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZUMEAI6>(arg0, 9, b"MizumeAI6", b"Mizume AI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZgQw2tpn12hDteMZ9KrZJg2kvLMSFZrd89N4MPJaPNvN"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIZUMEAI6>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZUMEAI6>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZUMEAI6>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

