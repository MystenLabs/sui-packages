module 0xfebf578cd3a8af0f7ccd752e0ad82e9f632c371d6e74b9748a51accd6b6e3899::wail {
    struct WAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIL>(arg0, 6, b"WAIL", b"WAILORD", b"WAIL IS THE KING!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieiorpshoc5zoquaqybnhjlqf45ljf2gpq2qnajdblp35m55w7cey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

