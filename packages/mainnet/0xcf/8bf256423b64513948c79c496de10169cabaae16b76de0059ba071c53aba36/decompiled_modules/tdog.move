module 0xcf8bf256423b64513948c79c496de10169cabaae16b76de0059ba071c53aba36::tdog {
    struct TDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDOG>(arg0, 6, b"TDOG", b"Trench Dog", b"TrenchDog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiehhqbbus55btkl5igxnziuh773ltlcoe5lculbunr6hlgy4c7nim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

