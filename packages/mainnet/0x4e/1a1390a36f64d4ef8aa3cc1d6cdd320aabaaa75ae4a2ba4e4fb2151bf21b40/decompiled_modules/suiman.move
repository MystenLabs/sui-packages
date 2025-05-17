module 0x4e1a1390a36f64d4ef8aa3cc1d6cdd320aabaaa75ae4a2ba4e4fb2151bf21b40::suiman {
    struct SUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAN>(arg0, 6, b"SUIMAN", b"Suiman hero", b"YOU KNOW WHO THE REAL HERO IS HERE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigzvagiqptwkhtgeoir7ih6wztbodgahrhywjodlkxzkmq6opl3xi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

