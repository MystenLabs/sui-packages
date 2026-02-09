module 0x3a29a8a2cd06a95b4c81a7cb1b7f9fc2c0a66e44e1ee3de8309a42b2d1e910dd::primary_020 {
    struct PRIMARY_020 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_020>, arg1: 0x2::coin::Coin<PRIMARY_020>) {
        0x2::coin::burn<PRIMARY_020>(arg0, arg1);
    }

    fun init(arg0: PRIMARY_020, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMARY_020>(arg0, 9, b"SUI_R2620_R1898", b"Sui (Reserve) (Reserve)", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-Wrxk4a_-BM.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PRIMARY_020>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIMARY_020>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    public fun supply(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_020>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PRIMARY_020> {
        0x2::coin::mint<PRIMARY_020>(arg0, arg1, arg2)
    }

    public entry fun supply_to(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_020>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIMARY_020>>(0x2::coin::mint<PRIMARY_020>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

