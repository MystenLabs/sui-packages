module 0x333e1565c9ac96de8bdac42c70a9b3d18ce767df41c9e5cfa2e06a42c849cc23::jui {
    struct JUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUI>(arg0, 6, b"JUI", b"Jui On Sui", b"Mountain Jew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibqi6u3duess7hpxabvoespd7htttniao5une5y3c2oe57prghxsu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

