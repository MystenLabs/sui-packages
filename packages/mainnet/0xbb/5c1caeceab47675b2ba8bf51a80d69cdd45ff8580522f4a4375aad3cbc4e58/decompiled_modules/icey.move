module 0xbb5c1caeceab47675b2ba8bf51a80d69cdd45ff8580522f4a4375aad3cbc4e58::icey {
    struct ICEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICEY>(arg0, 6, b"ICEY", b"Icey In Sui", b"An ice cube with sunglasses riding a snowboard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibprdts2rscuvjnvip7bthjnulgmnrgknj26ieo3xes6dkutatekq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ICEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

