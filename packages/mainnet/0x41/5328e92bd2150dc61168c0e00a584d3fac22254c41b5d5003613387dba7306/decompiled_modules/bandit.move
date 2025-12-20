module 0x415328e92bd2150dc61168c0e00a584d3fac22254c41b5d5003613387dba7306::bandit {
    struct BANDIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANDIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDIT>(arg0, 6, b"BANDIT", b"Le Bandit on Sui Official", b"A memecoin for the refined degen. Join the most elegant heist in crypto history.. Not a rug, a heist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieebhzpaaueb4cdzi74wse33d6ywzaaphlmdwlegl6kca7iqo6cke")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BANDIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

