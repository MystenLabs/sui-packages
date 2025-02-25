module 0xdce2b27379a84140c93065de8a492127248246eba0fb005302d051d13d427578::fund {
    struct FUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUND>(arg0, 6, b"FUND", b"Blockparty", b"Blockparty is a cutting-edge cryptocurrency that operates as a digital share in a hedge fund specializing in Bitcoin (BTC), artificial intelligence (AI), and emerging technologies. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1740510282030.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

