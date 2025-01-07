module 0x4908853c3d41f0a68ae88a1d331aed1292c62bc154de4367e3c4da196db17001::lp_token {
    struct LP_TOKEN has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: LP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_TOKEN>(arg0, 9, b"USDT-USDC vaultLP Cetus", b"USDT-USDC Cetus Vault LP Token", b"Cetus Vault LP Token, USDT-USDC pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dzuxtnuvuq7xqcurpbk4udj74zm2h5c52ftpaxsmgvxdt3fxtgva.arweave.net/Hml5tpWkP3gKkXhVyg0_5lmj9F3RZvBeTDVuOey3mao")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LP_TOKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_TOKEN>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<LP_TOKEN>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<LP_TOKEN>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

