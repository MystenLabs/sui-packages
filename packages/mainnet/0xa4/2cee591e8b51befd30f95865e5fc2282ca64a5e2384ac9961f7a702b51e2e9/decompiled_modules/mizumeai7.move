module 0xa42cee591e8b51befd30f95865e5fc2282ca64a5e2384ac9961f7a702b51e2e9::mizumeai7 {
    struct MIZUMEAI7 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MIZUMEAI7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZUMEAI7>(arg0, 9, b"MizumeAI7", b"Mizume AI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZgQw2tpn12hDteMZ9KrZJg2kvLMSFZrd89N4MPJaPNvN"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIZUMEAI7>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZUMEAI7>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MIZUMEAI7>>(v2);
    }

    // decompiled from Move bytecode v6
}

