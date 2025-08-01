module 0x8f1f571b3de86e6e88cc01b175cae58a051cbb117462ceb5102583affc60f821::rato {
    struct RATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATO>(arg0, 6, b"RATO", b"Rato The Rat", b"The Newest Matt Furie Character.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifnnfob5ia4vqzltsv324bbtrxa2ryrbroornpcfgst5jetvkuiwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RATO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

