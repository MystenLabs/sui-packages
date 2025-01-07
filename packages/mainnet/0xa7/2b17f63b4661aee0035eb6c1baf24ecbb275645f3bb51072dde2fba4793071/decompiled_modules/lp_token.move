module 0xa72b17f63b4661aee0035eb6c1baf24ecbb275645f3bb51072dde2fba4793071::lp_token {
    struct LP_TOKEN has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: LP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_TOKEN>(arg0, 9, b"USDT-USDC vaultLP Cetus", b"USDT-USDC Cetus Vault LP Token", b"Cetus Vault LP Token, USDT_USDC pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yd4ro365yw67pia6vjysex7ub3hviwgdukmtgoan7hvwaz4visia.arweave.net/wPkXb93FvfegHqpxIl_0Ds9UWMOimTM4DfnrYGeVRJA")), arg1);
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

