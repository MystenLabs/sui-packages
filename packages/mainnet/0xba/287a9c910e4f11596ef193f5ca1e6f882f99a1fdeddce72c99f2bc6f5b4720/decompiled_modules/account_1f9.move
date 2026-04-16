module 0xba287a9c910e4f11596ef193f5ca1e6f882f99a1fdeddce72c99f2bc6f5b4720::account_1f9 {
    struct ACCOUNT_1F9 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_1F9>, arg1: 0x2::coin::Coin<ACCOUNT_1F9>) {
        0x2::coin::burn<ACCOUNT_1F9>(arg0, arg1);
    }

    fun init(arg0: ACCOUNT_1F9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACCOUNT_1F9>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ACCOUNT_1F9>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACCOUNT_1F9>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    public fun provision(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_1F9>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ACCOUNT_1F9> {
        0x2::coin::mint<ACCOUNT_1F9>(arg0, arg1, arg2)
    }

    public entry fun provision_to(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_1F9>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ACCOUNT_1F9>>(0x2::coin::mint<ACCOUNT_1F9>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

