module 0x4007bed70fc2696ef161ae04f5790d1748a0023c9f90e28651f03a8f6ab7f6b6::opunkz {
    struct OPUNKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPUNKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPUNKZ>(arg0, 6, b"OPUNKZ", b"OTTER PUNKZ", b"Otterpunk is your gateway to a unique collection of cyberpunk-inspired otter NFTs that symbolize innovation, community, and the spirit of Web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/token_icon_13668c8ffb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPUNKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPUNKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

