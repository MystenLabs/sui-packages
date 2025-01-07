module 0x19fc5142915a90250297970496d265b605e8944bea1fb4a8873ba94263267889::smc {
    struct SMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SMC>(arg0, 6, b"SMC", b"Sui Meme Cat", b"This is completely 100% Just for fun memecoin. It's up to you if you want to help me complete the Bonding Curve of this token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/e83fe73a_6ab2_46e9_abe1_99a08f1a9274_8f94b4a625.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

