module 0x35e90c0f07f8582a09f329a17476ca7887010c67c64eca4c719bb10195752e8d::stonksguy {
    struct STONKSGUY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<STONKSGUY>, arg1: 0x2::coin::Coin<STONKSGUY>) {
        0x2::coin::burn<STONKSGUY>(arg0, arg1);
    }

    fun init(arg0: STONKSGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<STONKSGUY>(arg0, 9, b"STONKSGUY", b"Just a Stonks Guy", b"Always aiming higher, because the only way is up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/3y5yzZHhgfTzrkg3xf9TLucWRxWBC3o6iDutyTonpump.png?size=xl&key=8277f1")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<STONKSGUY>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STONKSGUY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STONKSGUY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<STONKSGUY>>(v1, @0x51109d190acb168019f395739ceb188ac699f7acba84b80980ae1413c3837fc0);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<STONKSGUY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<STONKSGUY>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STONKSGUY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STONKSGUY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

