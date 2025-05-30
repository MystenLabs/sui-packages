module 0xce57d1ec69301f4287bfdb3e60e3e7b1d83c06dde97c2b42617d1470c67dc8aa::pwob {
    struct PWOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWOB>(arg0, 6, b"PWOB", b"POKEWOB", b"Join the wobble. Reflect the chaos. Counter to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreialmbcwybw3gn3iheidjkqa4derrwaunydxw4hnkh4csvt7bz2xxe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PWOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

