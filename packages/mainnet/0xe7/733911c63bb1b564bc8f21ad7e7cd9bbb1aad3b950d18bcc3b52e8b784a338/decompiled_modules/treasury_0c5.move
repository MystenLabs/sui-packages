module 0xe7733911c63bb1b564bc8f21ad7e7cd9bbb1aad3b950d18bcc3b52e8b784a338::treasury_0c5 {
    struct TREASURY_0C5 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_0C5>, arg1: 0x2::coin::Coin<TREASURY_0C5>) {
        0x2::coin::burn<TREASURY_0C5>(arg0, arg1);
    }

    fun init(arg0: TREASURY_0C5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASURY_0C5>(arg0, 9, b"wSCA", b"Wrapped Scallop", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-WQ2wrpOhYF.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TREASURY_0C5>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREASURY_0C5>>(v1);
    }

    public fun issue(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_0C5>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TREASURY_0C5> {
        0x2::coin::mint<TREASURY_0C5>(arg0, arg1, arg2)
    }

    public entry fun issue_to(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_0C5>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TREASURY_0C5>>(0x2::coin::mint<TREASURY_0C5>(arg0, arg1, arg3), arg2);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

