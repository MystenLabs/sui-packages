module 0x43ab02fb532ae7dc79c1c8c77624cc6005213ec039e36ce00c86a2e9956a7536::squirtlive {
    struct SQUIRTLIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRTLIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRTLIVE>(arg0, 6, b"SquirtLive", b"Oiled Up live Twitch", b"https://twitchs.cam/SquirtLive", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidy7olgpgjrl7kzhffy3ke7lh53jhnwisegdgr2wuzbtfyrqvpdqy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRTLIVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUIRTLIVE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

