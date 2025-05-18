module 0x6f271e5360476552bedac22276734c13b7dba62bb1244b70a57cc6998ccc808::suilama {
    struct SUILAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMA>(arg0, 6, b"SUILAMA", b"SUILAMA the Official Unofficial Sui Mascot", b"Solama the Official Unofficial Sui Mascot has now come in the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreica37dmbyflg64gbujnzrarumnchpsk4y4e4ec5gvykowwda2hvt4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILAMA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

