module 0xdd806a26da3115bb1d276af22a5b996b16864f71f05891c081c5aef937aecc76::one {
    struct ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE>(arg0, 6, b"ONE", b"ONE", b"To unite global creators and innovators in a decentralized ecosystem where collective wisdom drives sustainable growth, empowering individuals to shape the future of digital collaboration while fostering economic opportunities through transparent governance and creative expression.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/20f086c0-f962-11ef-987d-fb68e6b59a77")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONE>>(v1);
        0x2::coin::mint_and_transfer<ONE>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

