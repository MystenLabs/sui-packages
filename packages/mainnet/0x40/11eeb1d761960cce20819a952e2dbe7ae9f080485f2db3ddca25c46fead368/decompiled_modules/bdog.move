module 0x4011eeb1d761960cce20819a952e2dbe7ae9f080485f2db3ddca25c46fead368::bdog {
    struct BDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDOG>(arg0, 6, b"BDOG", b"BUNNYDOG", x"2442444f472c205375692773206265737420646f672120416c776179732068756e67727920666f7220686f74646f67732e204d6f7265207468616e206a757374206120636f696e2c2069742773207468652064617767206f66205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731001172233.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

