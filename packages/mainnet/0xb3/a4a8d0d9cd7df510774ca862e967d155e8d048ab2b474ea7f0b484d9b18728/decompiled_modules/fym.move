module 0xb3a4a8d0d9cd7df510774ca862e967d155e8d048ab2b474ea7f0b484d9b18728::fym {
    struct FYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYM>(arg0, 6, b"FYM", b"FUCK YOU MAN", b"FUCK YOU MAN fuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaggqglf2f2lnks37xto7txdwfmch3ccoaxqwxmvabpg7gj625qz4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FYM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

