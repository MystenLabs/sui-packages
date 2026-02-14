module 0xfb273a809b6aa0e9d51e44554673cd60ed70025ab1162c9d460fb026488882f0::controller_6c4 {
    struct CONTROLLER_6C4 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_6C4>, arg1: 0x2::coin::Coin<CONTROLLER_6C4>) {
        0x2::coin::burn<CONTROLLER_6C4>(arg0, arg1);
    }

    fun init(arg0: CONTROLLER_6C4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONTROLLER_6C4>(arg0, 9, b"WDEEP", b"DeepBook Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-6ncg2P-RyS.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CONTROLLER_6C4>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONTROLLER_6C4>>(v1);
    }

    public fun invoke(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_6C4>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CONTROLLER_6C4> {
        0x2::coin::mint<CONTROLLER_6C4>(arg0, arg1, arg2)
    }

    public entry fun invoke_to(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_6C4>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CONTROLLER_6C4>>(0x2::coin::mint<CONTROLLER_6C4>(arg0, arg1, arg3), arg2);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

