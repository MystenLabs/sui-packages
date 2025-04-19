module 0xba0e40b0fb65205186dae3fd313d14e103eec329a35f2890794cbe5c670e24f::cejus {
    struct CEJUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEJUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEJUS>(arg0, 6, b"Cejus", b"Cejus whale", b"My name is Cejus, a lovable meme born from the love for Sui and Cetus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifyyuvcmyfuaerzbvayw4kcz72alynxiznatihw4uzit4xais6rte")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEJUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CEJUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

