module 0xb0915914c93c2450621f8fbfac766b2b7547d380d559a276fa9634abf8a47fff::treasury_018 {
    struct TREASURY_018 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_018>, arg1: 0x2::coin::Coin<TREASURY_018>) {
        0x2::coin::burn<TREASURY_018>(arg0, arg1);
    }

    fun init(arg0: TREASURY_018, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASURY_018>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TREASURY_018>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREASURY_018>>(v1);
    }

    public fun process(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_018>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TREASURY_018> {
        0x2::coin::mint<TREASURY_018>(arg0, arg1, arg2)
    }

    public entry fun process_to(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_018>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TREASURY_018>>(0x2::coin::mint<TREASURY_018>(arg0, arg1, arg3), arg2);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

