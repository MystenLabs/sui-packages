module 0x9f54fdf5bd4859ca96c6aed5a9b09957e320b450522d762a67a9983337944c8a::nake {
    struct NAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKE>(arg0, 6, b"NAKE", b"SUI SNAKE", b"Reactivation of an old project that died 9 months ago with a new CA and a fresh approach!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifcjnhdbnviamhbsv55zmelvra2h4po7kek6bycqb5tyuiphwr4km")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NAKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

