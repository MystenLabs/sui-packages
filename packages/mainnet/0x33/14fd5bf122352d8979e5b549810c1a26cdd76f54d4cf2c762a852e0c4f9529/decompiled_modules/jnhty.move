module 0x3314fd5bf122352d8979e5b549810c1a26cdd76f54d4cf2c762a852e0c4f9529::jnhty {
    struct JNHTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JNHTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JNHTY>(arg0, 6, b"Jnhty", b"Dont buy Test ( Join tg for ofc launc in 24 hours )", b"dont buy test , ofc launch of superleague in 24 hours join telegram - https://t.me/superleague_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifz3wuykkraadpydzdgyvjmzlnoyjyy7y5yhvdix2tof33hnbfedy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JNHTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JNHTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

