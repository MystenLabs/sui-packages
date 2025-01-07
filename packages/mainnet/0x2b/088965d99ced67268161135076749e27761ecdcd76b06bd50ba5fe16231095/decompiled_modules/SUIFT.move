module 0x2b088965d99ced67268161135076749e27761ecdcd76b06bd50ba5fe16231095::SUIFT {
    struct SUIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFT>(arg0, 6, b"SUIFT", b"Taylor Suift", b"Paradoy account. Living out the life of Miss Suift on the Move blockchain of choice; SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://black-written-grasshopper-675.mypinata.cloud/ipfs/QmQ2hzthKnreN9davcBh4bMPe4JCfiJ4TpJWGTdKUuNTeP"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIFT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

