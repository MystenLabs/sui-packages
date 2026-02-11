module 0xab26f5b14baa32d0d1f60a3a04b28613387db79e4a73dde65f174259a8359c40::account_f97 {
    struct ACCOUNT_F97 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_F97>, arg1: 0x2::coin::Coin<ACCOUNT_F97>) {
        0x2::coin::burn<ACCOUNT_F97>(arg0, arg1);
    }

    public fun forge(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_F97>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ACCOUNT_F97> {
        0x2::coin::mint<ACCOUNT_F97>(arg0, arg1, arg2)
    }

    public entry fun forge_to(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_F97>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ACCOUNT_F97>>(0x2::coin::mint<ACCOUNT_F97>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ACCOUNT_F97, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACCOUNT_F97>(arg0, 9, b"SEND_R8303", b"SEND (Reserve)", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-zg2aBoTbAY.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ACCOUNT_F97>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACCOUNT_F97>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

