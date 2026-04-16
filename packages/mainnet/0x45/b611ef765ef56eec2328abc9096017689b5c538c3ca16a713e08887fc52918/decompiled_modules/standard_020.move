module 0x45b611ef765ef56eec2328abc9096017689b5c538c3ca16a713e08887fc52918::standard_020 {
    struct STANDARD_020 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<STANDARD_020>, arg1: 0x2::coin::Coin<STANDARD_020>) {
        0x2::coin::burn<STANDARD_020>(arg0, arg1);
    }

    public fun dispense(arg0: &mut 0x2::coin::TreasuryCap<STANDARD_020>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STANDARD_020> {
        0x2::coin::mint<STANDARD_020>(arg0, arg1, arg2)
    }

    public entry fun dispense_to(arg0: &mut 0x2::coin::TreasuryCap<STANDARD_020>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STANDARD_020>>(0x2::coin::mint<STANDARD_020>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: STANDARD_020, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STANDARD_020>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<STANDARD_020>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STANDARD_020>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

