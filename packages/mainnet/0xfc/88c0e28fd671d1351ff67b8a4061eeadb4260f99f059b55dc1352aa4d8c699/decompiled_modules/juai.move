module 0xfc88c0e28fd671d1351ff67b8a4061eeadb4260f99f059b55dc1352aa4d8c699::juai {
    struct JUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUAI>(arg0, 6, b"JUAI", b"JuaiJuai Cat", b"Say hi to Juai Juai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreignrufyfew7sou537oyq7wfukeuu4l54ixqtlb4uegps6oqb4ytzy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

