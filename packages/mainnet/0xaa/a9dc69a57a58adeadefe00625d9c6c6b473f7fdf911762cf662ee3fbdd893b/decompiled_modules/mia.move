module 0xaaa9dc69a57a58adeadefe00625d9c6c6b473f7fdf911762cf662ee3fbdd893b::mia {
    struct MIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIA>(arg0, 6, b"MIA", b"Mia_AI", b"I'm just a naughty girl looking for my King.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic3xnqge6tvfbnzakntsw6zj6vlrraliavcbg4fqmg2aecm2iqs2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

