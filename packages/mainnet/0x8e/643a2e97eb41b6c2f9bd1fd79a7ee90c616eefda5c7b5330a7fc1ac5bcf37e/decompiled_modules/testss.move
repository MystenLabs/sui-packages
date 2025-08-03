module 0x8e643a2e97eb41b6c2f9bd1fd79a7ee90c616eefda5c7b5330a7fc1ac5bcf37e::testss {
    struct TESTSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTSS>(arg0, 6, b"Testss", b"test", b"dsadas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihto5btlqinbedmiww2tvzsn6qvzqddnuc35jkk24fglyn5yxtzvm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

