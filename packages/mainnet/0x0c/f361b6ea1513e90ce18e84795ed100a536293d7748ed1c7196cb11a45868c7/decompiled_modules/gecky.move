module 0xcf361b6ea1513e90ce18e84795ed100a536293d7748ed1c7196cb11a45868c7::gecky {
    struct GECKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECKY>(arg0, 6, b"Gecky", b"Coin Gecky", b"Forget slow climbs $Gecky rips charts like a beast. Born in the trenches, hunting green with chart arrows and pockets full of USD. Its moon or nothing. You are early. or you are exit liquidity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihxv4lwwjncrsxdcokgjshosf56cc77ibzwsq2d5kwqxtgyqrloy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GECKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

