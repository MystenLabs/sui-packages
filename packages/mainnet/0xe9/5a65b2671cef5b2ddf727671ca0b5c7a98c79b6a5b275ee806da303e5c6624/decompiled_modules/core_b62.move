module 0xe95a65b2671cef5b2ddf727671ca0b5c7a98c79b6a5b275ee806da303e5c6624::core_b62 {
    struct CORE_B62 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CORE_B62>, arg1: 0x2::coin::Coin<CORE_B62>) {
        0x2::coin::burn<CORE_B62>(arg0, arg1);
    }

    fun init(arg0: CORE_B62, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE_B62>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CORE_B62>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE_B62>>(v1);
    }

    public fun invoke(arg0: &mut 0x2::coin::TreasuryCap<CORE_B62>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CORE_B62> {
        0x2::coin::mint<CORE_B62>(arg0, arg1, arg2)
    }

    public entry fun invoke_to(arg0: &mut 0x2::coin::TreasuryCap<CORE_B62>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CORE_B62>>(0x2::coin::mint<CORE_B62>(arg0, arg1, arg3), arg2);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

