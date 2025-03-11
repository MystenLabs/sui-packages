module 0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet {
    struct TYASRIOCHAOFAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYASRIOCHAOFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYASRIOCHAOFAUCET>(arg0, 8, b"TYASRIOCHAOFAUCET", b"TYASRIOCHAOFAUCET", b"It's a faucet publish by tyasrioChao", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/tyasrioChao/assets/refs/heads/main/cat.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TYASRIOCHAOFAUCET>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYASRIOCHAOFAUCET>>(v1);
    }

    // decompiled from Move bytecode v6
}

