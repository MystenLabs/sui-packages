module 0x2de876474603b298b69f68629493849414ae33fc15fd611eb1a838204c383823::bmew {
    struct BMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMEW>(arg0, 6, b"BMEW", b"BabyMEW", b"BABY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeid5x42ipqjhtqfofqsbyda456wiv7zintzidtagwwtmlucub2b27y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BMEW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

