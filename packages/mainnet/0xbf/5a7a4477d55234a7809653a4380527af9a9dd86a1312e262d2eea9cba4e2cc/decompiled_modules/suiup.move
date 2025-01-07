module 0xbf5a7a4477d55234a7809653a4380527af9a9dd86a1312e262d2eea9cba4e2cc::suiup {
    struct SUIUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIUP>(arg0, 6, b"SUIUP", b"UPSUI", b"UPSUI is a meme on the Sui ecosystem, representing a new, representative, and decentralized breeze. Community-driven!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DM_Hand1_665c2cb8bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

