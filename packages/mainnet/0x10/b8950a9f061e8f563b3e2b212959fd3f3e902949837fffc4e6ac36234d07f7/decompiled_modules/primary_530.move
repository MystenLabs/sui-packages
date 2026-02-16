module 0x10b8950a9f061e8f563b3e2b212959fd3f3e902949837fffc4e6ac36234d07f7::primary_530 {
    struct PRIMARY_530 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_530>, arg1: 0x2::coin::Coin<PRIMARY_530>) {
        0x2::coin::burn<PRIMARY_530>(arg0, arg1);
    }

    fun init(arg0: PRIMARY_530, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMARY_530>(arg0, 9, b"wNS", b"Wrapped SuiNS Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-ps9JVx4-BP.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PRIMARY_530>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIMARY_530>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    public fun supply(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_530>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PRIMARY_530> {
        0x2::coin::mint<PRIMARY_530>(arg0, arg1, arg2)
    }

    public entry fun supply_to(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_530>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIMARY_530>>(0x2::coin::mint<PRIMARY_530>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

