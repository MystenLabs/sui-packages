module 0xa2367aff5d90799bf1c006c48db197a321b1aeb14426ea4d7a0d5837c136e01f::bdg {
    struct BDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDG>(arg0, 6, b"BDG", b"Bunnydog on SUI", x"2442444f472c205375692773206265737420646f672120416c776179732068756e67727920666f7220686f74646f67732e204d6f7265207468616e206a757374206120636f696e2c2069742773207468652064617767206f66205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731013072413.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

