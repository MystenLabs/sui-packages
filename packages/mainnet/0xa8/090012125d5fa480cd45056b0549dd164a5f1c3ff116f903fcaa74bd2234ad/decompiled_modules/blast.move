module 0xa8090012125d5fa480cd45056b0549dd164a5f1c3ff116f903fcaa74bd2234ad::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAST>(arg0, 6, b"BLAST", b"Blastoise Pokesui", b"$BLAST ATTACK ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifqnovttbdfymvbwqpl7inpbm5ourlyg73yvdvtpiebkqyapjbtfi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLAST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

