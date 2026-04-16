module 0x5bb47010aaa994fda42d1bd079609adafd9e1ef7d1bf25db0c236b321cb96289::controller_7d4 {
    struct CONTROLLER_7D4 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_7D4>, arg1: 0x2::coin::Coin<CONTROLLER_7D4>) {
        0x2::coin::burn<CONTROLLER_7D4>(arg0, arg1);
    }

    public fun generate(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_7D4>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CONTROLLER_7D4> {
        0x2::coin::mint<CONTROLLER_7D4>(arg0, arg1, arg2)
    }

    public entry fun generate_to(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_7D4>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CONTROLLER_7D4>>(0x2::coin::mint<CONTROLLER_7D4>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CONTROLLER_7D4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONTROLLER_7D4>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CONTROLLER_7D4>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONTROLLER_7D4>>(v1);
    }

    // decompiled from Move bytecode v6
}

