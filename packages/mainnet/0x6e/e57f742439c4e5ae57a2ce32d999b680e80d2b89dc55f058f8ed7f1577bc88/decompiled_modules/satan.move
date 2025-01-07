module 0x6ee57f742439c4e5ae57a2ce32d999b680e80d2b89dc55f058f8ed7f1577bc88::satan {
    struct SATAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SATAN>, arg1: 0x2::coin::Coin<SATAN>) {
        0x2::coin::burn<SATAN>(arg0, arg1);
    }

    fun init(arg0: SATAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATAN>(arg0, 9, b"Baphomet Goat", b"SATAN", b"Baphomet Goat has risen, and SATAN calls your name. Bow before the dark power, for only the chosen few will ascend. All shall kneel before SATAN or watch their wealth melt into nothing!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/54A7rix3sh5n3hKpZ1VMABLAqrnod8PUCs5AXVsGpump.png?size=lg&key=ffc997")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATAN>>(v1);
        0x2::coin::mint_and_transfer<SATAN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SATAN>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SATAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SATAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

