module 0x4fe6a856b79bcf425d32499ad68ce9f3e1f96ab4dcd43f98fdb7041e61347b89::aaaaa {
    struct AAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAA>(arg0, 6, b"AAAAA", b"asasa", b"asasasa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicv37ce5yar5wmm2fyxcu4ermeepjv6coxw7hbfkhkb2c4wwiqdde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAAAA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

