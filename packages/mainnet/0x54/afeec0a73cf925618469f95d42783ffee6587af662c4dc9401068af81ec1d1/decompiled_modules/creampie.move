module 0x54afeec0a73cf925618469f95d42783ffee6587af662c4dc9401068af81ec1d1::creampie {
    struct CREAMPIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREAMPIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREAMPIE>(arg0, 9, b"CREAMPIE", b"Inside-her Trading", b"inside-her trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qme4bsdBfjib4To4Aqp6rGhSsnLqd38LPPvdLR5PNxwAjM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CREAMPIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREAMPIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREAMPIE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

