module 0x6dda0d9a9550f650f884eed6defec04657a2a92365e3149b3c402d31249f8a79::walr {
    struct WALR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALR>(arg0, 6, b"WALR", b"WALR$ are Baller$", b"WALR is the most ambitious meme coin sailing the seven seas! We're rallying behind walrus.xyz, the true heroes building the next-gen decentralized storage protocol. The future of the web3 internet is decentralized. Join us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732202928791.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

