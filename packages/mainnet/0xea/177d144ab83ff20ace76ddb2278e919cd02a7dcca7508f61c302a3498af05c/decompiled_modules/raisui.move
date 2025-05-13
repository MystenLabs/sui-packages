module 0xea177d144ab83ff20ace76ddb2278e919cd02a7dcca7508f61c302a3498af05c::raisui {
    struct RAISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAISUI>(arg0, 6, b"RAISUI", b"Raichu on Sui", b"RAICHU will discharge 100000W for bonding", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibxtydfex6xtczz3bycd7ca3xbwenrvnjsth4fuxi6tmvsgmzvvae")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAISUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

