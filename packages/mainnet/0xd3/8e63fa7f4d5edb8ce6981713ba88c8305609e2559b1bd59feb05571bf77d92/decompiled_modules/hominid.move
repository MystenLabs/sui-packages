module 0xd38e63fa7f4d5edb8ce6981713ba88c8305609e2559b1bd59feb05571bf77d92::hominid {
    struct HOMINID has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMINID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMINID>(arg0, 6, b"HOMINID", b"Alien Hominid", b"one alien, one blaster, zero mercy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigw5pnofk4bf6di5mazvb3tu5kc4xergg26g3tpbg7naymyfez2ee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMINID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOMINID>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

