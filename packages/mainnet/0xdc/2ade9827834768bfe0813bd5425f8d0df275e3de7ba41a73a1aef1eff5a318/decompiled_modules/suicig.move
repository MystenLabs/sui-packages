module 0xdc2ade9827834768bfe0813bd5425f8d0df275e3de7ba41a73a1aef1eff5a318::suicig {
    struct SUICIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIG>(arg0, 6, b"SUICIG", b"Sui Cig", b"Ya got a SUIRETTE mate?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifabiouip3aez4wyuep3rdtdabawj7d5vnhwj3eynu7ykfslutptq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

