module 0xab60ca71dcf7a7e0271acb699d8de240cbc035135c6126694a384463294ef724::sui_pepe {
    struct SUI_PEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI_PEPE>, arg1: 0x2::coin::Coin<SUI_PEPE>) {
        0x2::coin::burn<SUI_PEPE>(arg0, arg1);
    }

    fun init(arg0: SUI_PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_PEPE>(arg0, 9, b"PEPE", b"PEPE", b"https://twitter.com/SuiThePepe t.me/SuiThePepe suipepe.wtf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://zrjvjlgowqpzettannu3vprvedwyj6ezvrkxi5xjhrugeg6gpx2q.arweave.net/zFNUrM60H5JOYGtpur41IO2E-JmsVXR26TxoYhvGffU"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_PEPE>>(v1);
        0x2::coin::mint_and_transfer<SUI_PEPE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUI_PEPE>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_PEPE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUI_PEPE>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

