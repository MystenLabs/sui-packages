module 0xcce4a3d74d9e455ca839e8cac996e24bca1ecfc4636b44ce8fb86ac5895333d3::moondog {
    struct MOONDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONDOG>(arg0, 6, b"MOONDOG", b"MOONDOG on BAGS", b"\"MOONDOG Unchained on SUI\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiaeohyjakoqsopivw2q46f45ssimfupcjakjh5eghb6ccts5wu2ey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

