module 0x59ccbb4f0bbe81bc6cf3597b0c9c1bc2349712918665c838b5a9a11e2597f134::dia {
    struct DIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIA>(arg0, 6, b"DIA", b"Diamond", b"j4f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiez43lssgngn4aheerwio56a7v2mir224jzqypk7lptdbjqgfzsu4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

