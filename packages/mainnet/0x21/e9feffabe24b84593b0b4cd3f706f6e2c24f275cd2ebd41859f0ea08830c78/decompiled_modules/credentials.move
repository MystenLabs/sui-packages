module 0x21e9feffabe24b84593b0b4cd3f706f6e2c24f275cd2ebd41859f0ea08830c78::credentials {
    struct CREDENTIALS has drop {
        dummy_field: bool,
    }

    public entry fun allocate_credential(arg0: &mut 0x2::coin::TreasuryCap<CREDENTIALS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CREDENTIALS>>(0x2::coin::mint<CREDENTIALS>(arg0, arg1, arg3), arg2);
    }

    public entry fun deallocate_credential(arg0: &mut 0x2::coin::TreasuryCap<CREDENTIALS>, arg1: 0x2::coin::Coin<CREDENTIALS>) {
        0x2::coin::burn<CREDENTIALS>(arg0, arg1);
    }

    fun init(arg0: CREDENTIALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREDENTIALS>(arg0, 9, b"ACRED", b"Access Credential", b"Tiered access credential for protocol permission management", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://access.layer.protocol/cred.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREDENTIALS>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CREDENTIALS>>(v0);
    }

    // decompiled from Move bytecode v6
}

