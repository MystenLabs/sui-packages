module 0x66ffdbf094ef6f9c712e39abb543b6d15903f22cf9a8f20da20fabfadb60ae9::move4all {
    struct MOVE4ALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVE4ALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVE4ALL>(arg0, 6, b"MOVE4ALL", b"Movepump is for everyone", b"Move4All", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060150_0ff153957f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVE4ALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVE4ALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

