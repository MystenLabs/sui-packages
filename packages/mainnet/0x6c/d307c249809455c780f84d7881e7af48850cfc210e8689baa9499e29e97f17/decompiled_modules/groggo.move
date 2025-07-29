module 0x6cd307c249809455c780f84d7881e7af48850cfc210e8689baa9499e29e97f17::groggo {
    struct GROGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROGGO>(arg0, 6, b"GROGGO", b"Groggo on SUI", b"Groggo is the only blue frog in all of Matts works, joining Matt Furies beloved collection of fan-favorite frog characters. Reminiscent of Pepe, Groggo has earned the affectionate nickname, The Blue Pepe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidj7mbxv6jxz3fjfc43jtoq33tjrq5bzfqwnknbrrn4jbhjhhqf2q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GROGGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

