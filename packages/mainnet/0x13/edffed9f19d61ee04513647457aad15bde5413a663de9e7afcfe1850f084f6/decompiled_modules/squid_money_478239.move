module 0x13edffed9f19d61ee04513647457aad15bde5413a663de9e7afcfe1850f084f6::squid_money_478239 {
    struct SQUID_MONEY_478239 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID_MONEY_478239, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID_MONEY_478239>(arg0, 9, b"SQD239", b"SQUIDTOKEN478239", b"The ultra-rare squid beast of the deep. Mint at your own risk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/IFK9dSr.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUID_MONEY_478239>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID_MONEY_478239>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SQUID_MONEY_478239>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SQUID_MONEY_478239>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

