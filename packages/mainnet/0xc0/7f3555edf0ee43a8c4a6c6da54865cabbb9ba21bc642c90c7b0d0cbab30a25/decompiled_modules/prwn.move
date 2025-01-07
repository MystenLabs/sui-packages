module 0xc07f3555edf0ee43a8c4a6c6da54865cabbb9ba21bc642c90c7b0d0cbab30a25::prwn {
    struct PRWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRWN>(arg0, 6, b"PRWN", b"Prawnsui", b"Prawns for you, prawns for me, prawns for SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prawns_for_life_77db53ef1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

