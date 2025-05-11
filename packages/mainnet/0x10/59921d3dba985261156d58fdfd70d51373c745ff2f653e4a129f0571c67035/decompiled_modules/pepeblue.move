module 0x1059921d3dba985261156d58fdfd70d51373c745ff2f653e4a129f0571c67035::pepeblue {
    struct PEPEBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEBLUE>(arg0, 6, b"PEPEBLUE", b"PEPE on SUI", b"PEPE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib5xceczpfbjbyv2qv4zxudwsi36dg447rryhm2xmu7yaw4llesbe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPEBLUE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

