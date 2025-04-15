module 0x72fde0fb28809616784ed74bcb5cd2201d1296adf99543cb4bf3b4dea7cc44e2::sr00 {
    struct SR00 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SR00, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SR00>(arg0, 6, b"SR00", b"Sroom on MOONBAGS", b"New launch on Moonbags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreifyfk4bbt5eardsd3bsb7t4vwwhwtw6ssigcmdoxqaz4vccczjbeq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SR00>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SR00>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

