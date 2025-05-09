module 0xbd64049fa89482cc2a206a4a7c3a0fd11c4737e6238ea932b9f41f5969541b45::fog {
    struct FOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOG>(arg0, 9, b"FOG", b"fog", b"GET FOGGED!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/6bdTRHhdZenJQYLTxaYc8kH74GBNP9DoGhPnCjfypump.png?size=xl&key=508ae7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOG>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

