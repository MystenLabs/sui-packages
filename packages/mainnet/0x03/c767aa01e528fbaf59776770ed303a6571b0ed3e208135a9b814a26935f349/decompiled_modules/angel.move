module 0x3c767aa01e528fbaf59776770ed303a6571b0ed3e208135a9b814a26935f349::angel {
    struct ANGEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGEL>(arg0, 6, b"ANGEL", b"SUI ANGEL", b"SONNY ANGELS ON SUI! LETS GOOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sonny_b09249f5dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

