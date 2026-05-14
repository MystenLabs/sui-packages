module 0x7b5e31adaaf7008552cbc6cf37019447f64ad022aad7ab13f6524f0947229c4a::tast {
    struct TAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAST>(arg0, 6, b"TAST", b"test", b"dont buy test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidsz3vnuedsgmihoer6t3epnivmpxc2xkcn2pmms5f7pbey625dqq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

