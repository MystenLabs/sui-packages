module 0x3cf92b34732f63cfb822e4ac4c064a85f2478bef700c530859038e26fe94e362::icey {
    struct ICEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICEY>(arg0, 6, b"ICEY", b"Icey In Sui", b"Icey is a next-generation NFT project and social hub built on the Sui blockchain, designed to deliver an immersive, community-driven experience like no other. At its core, Icey combines crisp, distinctive art with utility-focused features that make it more than just a collectible - it`s a gateway into an expanding digital world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibprdts2rscuvjnvip7bthjnulgmnrgknj26ieo3xes6dkutatekq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ICEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

