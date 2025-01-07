module 0xa3f50e0e0d0b8f7c565d92f1d019ad948d0c3e965d8060348380b0392ae6b790::satan {
    struct SATAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATAN>(arg0, 9, b"SATAN", b"Baphomet Goat", b"Baphomet Goat has risen, and $SATAN calls your name. Bow before the dark power, for only the chosen few will ascend. All shall kneel before $SATAN or watch their wealth melt into nothing!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/54A7rix3sh5n3hKpZ1VMABLAqrnod8PUCs5AXVsGpump.png?size=lg&key=ffc997")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SATAN>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

