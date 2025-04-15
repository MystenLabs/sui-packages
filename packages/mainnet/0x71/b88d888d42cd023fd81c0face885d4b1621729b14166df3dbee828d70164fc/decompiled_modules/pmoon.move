module 0x71b88d888d42cd023fd81c0face885d4b1621729b14166df3dbee828d70164fc::pmoon {
    struct PMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMOON>(arg0, 6, b"PMoon", b"POKEMOONBAGS", b"FIRST POKEMON TOKEN ON MOONBAGS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreidtzc6426cmuqjwfmfjoopyfkig4es6fpcho7rhsdjb4zv2iqsbfi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PMOON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

