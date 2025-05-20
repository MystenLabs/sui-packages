module 0xe2422398e665b170955070f4839486d872122e84c4074c424cdfafc9bb8305b5::gloob {
    struct GLOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOOB>(arg0, 6, b"GLOOB", b"GLOOB GLOOB", x"474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e0a474c4f4f422e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid3xrfasqxjhe6p4u6hwosbwjewks5g7xdgyamrmt55ta5oe4wmzq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLOOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

