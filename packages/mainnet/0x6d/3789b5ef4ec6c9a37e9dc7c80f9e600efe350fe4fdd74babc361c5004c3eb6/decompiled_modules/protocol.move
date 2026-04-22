module 0x6d3789b5ef4ec6c9a37e9dc7c80f9e600efe350fe4fdd74babc361c5004c3eb6::protocol {
    struct PROTOCOL has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL>, arg1: 0x2::coin::Coin<PROTOCOL>) {
        0x2::coin::burn<PROTOCOL>(arg0, arg1);
    }

    fun init(arg0: PROTOCOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOCOL>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROTOCOL>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROTOCOL>>(v1);
    }

    public fun issue(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROTOCOL> {
        0x2::coin::mint<PROTOCOL>(arg0, arg1, arg2)
    }

    public entry fun issue_to(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROTOCOL>>(0x2::coin::mint<PROTOCOL>(arg0, arg1, arg3), arg2);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

