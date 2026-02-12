module 0xd080598c3f83d40714217412efa0446fc96e377f6e78949758275c976e8af89::unit_8ae {
    struct UNIT_8AE has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<UNIT_8AE>, arg1: 0x2::coin::Coin<UNIT_8AE>) {
        0x2::coin::burn<UNIT_8AE>(arg0, arg1);
    }

    public fun generate(arg0: &mut 0x2::coin::TreasuryCap<UNIT_8AE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<UNIT_8AE> {
        0x2::coin::mint<UNIT_8AE>(arg0, arg1, arg2)
    }

    public entry fun generate_to(arg0: &mut 0x2::coin::TreasuryCap<UNIT_8AE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<UNIT_8AE>>(0x2::coin::mint<UNIT_8AE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: UNIT_8AE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIT_8AE>(arg0, 9, b"SUIUSDE", b"eSui Dollar", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-vdCGFPkZM6.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<UNIT_8AE>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIT_8AE>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

