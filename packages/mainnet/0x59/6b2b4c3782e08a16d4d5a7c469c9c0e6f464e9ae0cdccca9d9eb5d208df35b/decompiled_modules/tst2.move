module 0x596b2b4c3782e08a16d4d5a7c469c9c0e6f464e9ae0cdccca9d9eb5d208df35b::tst2 {
    struct TST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST2>(arg0, 6, b"TST2", b"TST Token2", b"TST Test 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

