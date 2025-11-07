module 0xed9669848cf2ea569c6fe90963a5b3f49e488bfdcdd5d9e8e2cfc2e50461db49::nomeme {
    struct NOMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOMEME>(arg0, 9, b"NOMEME", b"No Memes on Sui", b"They told us to go to another chain. We made it here instead. This is $NOMEME.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeia34cxeolwydkyow4tusi7ln2flykfchkx5qoovt4vn4wlwp46mtq")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOMEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOMEME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

