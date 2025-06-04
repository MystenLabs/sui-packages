module 0x861cc04a94517f3741e7f014ea2ca6baff461ce7c543c5f9c99ef76170247373::suidier {
    struct SUIDIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDIER>(arg0, 6, b"SUIDIER", b"SUIDIER THE SOLDIER IN SUI", b"The first soldier in SUI - SUIDIER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiczpwbvuzh65sq7rmahq65mmypdwubdiknfdkwak4fjfxk3ozcf5a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDIER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDIER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

