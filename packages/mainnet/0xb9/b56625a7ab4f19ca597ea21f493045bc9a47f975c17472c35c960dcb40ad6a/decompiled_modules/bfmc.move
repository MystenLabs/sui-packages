module 0xb9b56625a7ab4f19ca597ea21f493045bc9a47f975c17472c35c960dcb40ad6a::bfmc {
    struct BFMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFMC>(arg0, 6, b"BFMC", b"Bored Fish Marine Club", b"Where bored fish ride the SUI wave without a drop of excitement!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihnurln5qsjo6drjr2afhcx3xkybtma3eqqire6i63i6rbr3244ky")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BFMC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

