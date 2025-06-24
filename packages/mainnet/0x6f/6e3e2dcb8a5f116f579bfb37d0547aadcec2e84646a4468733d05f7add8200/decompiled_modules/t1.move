module 0x6f6e3e2dcb8a5f116f579bfb37d0547aadcec2e84646a4468733d05f7add8200::t1 {
    struct T1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T1>(arg0, 6, b"T1", b"Test", b"Dont buy it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigdjzfgusjfuoptqn57hj34q4g3uas76tywiqnj25udassv5rls6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<T1>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

