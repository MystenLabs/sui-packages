module 0x7e00f8a256f6aaff961da90a211581c5131eba7bfbc722a4aa1669a9b3405cd6::tes {
    struct TES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TES>(arg0, 6, b"TES", b"TEST ON SUI", b"TEST SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicfeclnrxrcfpjb6ua7m2zzgirp53sfat7t6zkaesnyu2xkak2d5u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

