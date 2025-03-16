module 0xafeb1302196cd690e28f1f68604fbd44cd00a7d5a52feb128d400e239a825a26::meu_token {
    struct MEU_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEU_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEU_TOKEN>(arg0, 9, b"GMC", b"Generational Money Creation", b"A token designed to create long-term wealth and financial growth for future generations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-tiny-shrimp-206.mypinata.cloud/ipfs/bafkreigg2lqx7jfyenugzb4dwxcfgepbd2bwp2pchwzqkpl27hep5pnedi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEU_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEU_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEU_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEU_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

