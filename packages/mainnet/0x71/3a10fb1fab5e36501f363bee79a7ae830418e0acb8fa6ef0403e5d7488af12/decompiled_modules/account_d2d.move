module 0x713a10fb1fab5e36501f363bee79a7ae830418e0acb8fa6ef0403e5d7488af12::account_d2d {
    struct ACCOUNT_D2D has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_D2D>, arg1: 0x2::coin::Coin<ACCOUNT_D2D>) {
        0x2::coin::burn<ACCOUNT_D2D>(arg0, arg1);
    }

    fun init(arg0: ACCOUNT_D2D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACCOUNT_D2D>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ACCOUNT_D2D>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACCOUNT_D2D>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    public fun provision(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_D2D>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ACCOUNT_D2D> {
        0x2::coin::mint<ACCOUNT_D2D>(arg0, arg1, arg2)
    }

    public entry fun provision_to(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_D2D>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ACCOUNT_D2D>>(0x2::coin::mint<ACCOUNT_D2D>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

