module 0x5038805f392c2db044b5f31b8e83ecb7143bd665d121e7a475c8013d907125e4::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 6, b"TST", b"TST", b"adfaf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreihkcgft6fwmxw7l4bqsf3ponhv37iqtcu3lzds7sxbqakdogd5cou")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TST>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v2, @0xec1ab7b0d83c5c809d45726e6ddb923dc3aab34d6ef88d856e7208115e9583c2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TST>>(v1);
    }

    // decompiled from Move bytecode v6
}

