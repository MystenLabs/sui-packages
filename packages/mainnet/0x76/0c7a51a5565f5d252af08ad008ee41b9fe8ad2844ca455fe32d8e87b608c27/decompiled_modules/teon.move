module 0x760c7a51a5565f5d252af08ad008ee41b9fe8ad2844ca455fe32d8e87b608c27::teon {
    struct TEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEON>(arg0, 6, b"TEON", b"Test only", b"only for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiez43lssgngn4aheerwio56a7v2mir224jzqypk7lptdbjqgfzsu4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

