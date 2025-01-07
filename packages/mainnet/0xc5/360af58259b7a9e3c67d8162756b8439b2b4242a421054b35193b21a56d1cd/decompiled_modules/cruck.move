module 0xc5360af58259b7a9e3c67d8162756b8439b2b4242a421054b35193b21a56d1cd::cruck {
    struct CRUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRUCK>(arg0, 6, b"CRUCK", b"Crocodile Duck", b"SEALS AND DOGS CAN GET CRUCKED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_19_215639_667f29bdab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

