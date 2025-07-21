module 0xc5c69bbcac6051fc59b6cd4a4d90faee52a53e41b959b21908e8d57538b50d2b::eon {
    struct EON has drop {
        dummy_field: bool,
    }

    fun init(arg0: EON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EON>(arg0, 6, b"EON", b"EON", b"@suilaunchcoin @SuiAIFun @suilaunchcoin $EON + EON https://t.co/nQ5BcbPAnE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/eon-978eqd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

