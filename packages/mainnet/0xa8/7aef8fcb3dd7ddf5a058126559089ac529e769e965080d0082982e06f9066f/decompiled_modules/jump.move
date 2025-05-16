module 0xa87aef8fcb3dd7ddf5a058126559089ac529e769e965080d0082982e06f9066f::jump {
    struct JUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMP>(arg0, 6, b"JUMP", b"SuiJump", b"SUIJUMP Play and Win while enjoying fast payouts total anonymity and provably fair gaming experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibxjmrvn4kuts327mhch4syvc7oal3p5iudqvmoj5ssp2awsyzf5y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

