module 0xa6c076f9e84a3b82cfbead2f552bb31daa860680e329f7ce2665fc808d3528f2::pet {
    struct PET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PET>(arg0, 6, b"PET", b"SUIPET", b"First pet on memesui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigjvgx5ik3376osc3rtq4ccsvdo3uuqokvlia2snvzrxcwlsxkou4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

