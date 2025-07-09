module 0xd19c13abd1c58308c04bc54c884a49d06dc7e49242d5f123c3c136db264e9e6::aki {
    struct AKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKI>(arg0, 6, b"AKI", b"Aki Kun", b"$AKI, the supernatural force that controls the memecoin market on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiapw3vth3qeb5txgph7ftjp66pkylvurh5jsntxefgsk6ccgw7k74")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

