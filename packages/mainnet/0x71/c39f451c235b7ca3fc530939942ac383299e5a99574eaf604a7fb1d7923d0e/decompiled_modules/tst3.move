module 0x71c39f451c235b7ca3fc530939942ac383299e5a99574eaf604a7fb1d7923d0e::tst3 {
    struct TST3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST3>(arg0, 6, b"TST3", b"TESTING 3", b"Sorry, again :)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidm3gzjlojq43vequ3if2uji25y3gjujqyl2coziruxwa4t2txw4e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

