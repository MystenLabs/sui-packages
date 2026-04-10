module 0x202a6fe4617c4e9e656acc55f12b14595ddc873f9e9d467b0ccb1b9e6f3fc9be::unit_95b {
    struct UNIT_95B has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<UNIT_95B>, arg1: 0x2::coin::Coin<UNIT_95B>) {
        0x2::coin::burn<UNIT_95B>(arg0, arg1);
    }

    fun init(arg0: UNIT_95B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIT_95B>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<UNIT_95B>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIT_95B>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    public fun produce(arg0: &mut 0x2::coin::TreasuryCap<UNIT_95B>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<UNIT_95B> {
        0x2::coin::mint<UNIT_95B>(arg0, arg1, arg2)
    }

    public entry fun produce_to(arg0: &mut 0x2::coin::TreasuryCap<UNIT_95B>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<UNIT_95B>>(0x2::coin::mint<UNIT_95B>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

