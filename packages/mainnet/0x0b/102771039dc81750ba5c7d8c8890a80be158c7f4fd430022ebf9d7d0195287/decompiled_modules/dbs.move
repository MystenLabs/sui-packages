module 0xb102771039dc81750ba5c7d8c8890a80be158c7f4fd430022ebf9d7d0195287::dbs {
    struct DBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBS>(arg0, 6, b"DBS", b"DragonBallSui", b"Fresh out of the hyperbolic time chamber and onto the Sui chain, a little taste of nostalgia for everyone!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigqga4cedwfhfi2gdmbes3jnosykyt7s6g5rsl22p7atb4tvvuzqq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DBS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

