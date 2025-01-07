module 0x69422af0cb401fceadb90593bea44838684e49c7bcf8ae7687e670652be6abde::suipredator {
    struct SUIPREDATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPREDATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPREDATOR>(arg0, 6, b"SUIPREDATOR", b"SUI PREDATOR", b"SUI readying to eat all other blockchains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_1_272c5784e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPREDATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPREDATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

