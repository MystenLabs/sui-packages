module 0xb8ce9fa4300ef648472bed80fbd2393d8501d2456f8aadcad7c38d7c4e1c8f43::spark {
    struct SPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARK>(arg0, 6, b"SPARK", b"The Spark Arcanum", b"A Magic: The Gathering AI assistant for card lookup, card interactions, stack & phase reasoning, and an AI deck builder that references official rules. Funded by a community token on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig5cuebpld3d3hqppkbz7bl7fhb24mh5i2ped5dfjw4echeupwqga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPARK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

