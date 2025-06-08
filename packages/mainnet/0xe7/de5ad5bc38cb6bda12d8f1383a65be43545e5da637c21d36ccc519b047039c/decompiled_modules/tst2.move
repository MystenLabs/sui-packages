module 0xe7de5ad5bc38cb6bda12d8f1383a65be43545e5da637c21d36ccc519b047039c::tst2 {
    struct TST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST2>(arg0, 6, b"TST2", b"TESTING 2", b"Sorry, just test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidm3gzjlojq43vequ3if2uji25y3gjujqyl2coziruxwa4t2txw4e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

