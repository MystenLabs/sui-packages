module 0x4d9e6d5277f66ffdda2a76afa3571a464f68d192e0b6409fc3c5263b1548c8cb::controller_8b5 {
    struct CONTROLLER_8B5 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_8B5>, arg1: 0x2::coin::Coin<CONTROLLER_8B5>) {
        0x2::coin::burn<CONTROLLER_8B5>(arg0, arg1);
    }

    public fun distribute(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_8B5>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CONTROLLER_8B5> {
        0x2::coin::mint<CONTROLLER_8B5>(arg0, arg1, arg2)
    }

    public entry fun distribute_to(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_8B5>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CONTROLLER_8B5>>(0x2::coin::mint<CONTROLLER_8B5>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CONTROLLER_8B5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONTROLLER_8B5>(arg0, 9, b"wNS", b"Wrapped SuiNS Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-qSX-pvoR06.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CONTROLLER_8B5>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONTROLLER_8B5>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

