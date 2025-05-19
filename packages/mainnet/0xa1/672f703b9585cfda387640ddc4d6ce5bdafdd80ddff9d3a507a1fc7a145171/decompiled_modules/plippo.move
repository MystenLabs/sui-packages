module 0xa1672f703b9585cfda387640ddc4d6ce5bdafdd80ddff9d3a507a1fc7a145171::plippo {
    struct PLIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLIPPO>(arg0, 6, b"PLIPPO", b"Its Plippo", b"tiny menace, big heart degen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidiqkd5ymp4ngouucdwpktwpkthjbmfb67vwakiwpaf6sclf364iu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PLIPPO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

