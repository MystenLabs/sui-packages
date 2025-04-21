module 0xdfa15aefefef8c53bbeea4344f8b7554a7f767d409001529c4b7890d0e8bcf7f::boys {
    struct BOYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYS>(arg0, 6, b"BOYS", b"Boys Club on Sui", b"Re-launch of Boys Club on Sui, powered by MoonBag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig3eqc56wo6n3ehlrrokexwpxlelpdsnvou2isxxtz3cdlpwjsqya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOYS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

