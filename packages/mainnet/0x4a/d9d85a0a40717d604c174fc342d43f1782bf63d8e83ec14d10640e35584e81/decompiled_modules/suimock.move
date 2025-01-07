module 0x4ad9d85a0a40717d604c174fc342d43f1782bf63d8e83ec14d10640e35584e81::suimock {
    struct SUIMOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOCK>(arg0, 6, b"SuiMOCK", b"MOCK", b"Amplifying traders profits through tooling and bots on social applications like Discord and Telegram. Offering dozens of never before seen tools and bots to help you win.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_ca0245d5ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

