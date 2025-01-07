module 0xdde79fa3f265a744d56460e47cb726938055817a060a7de78a6525b7e571d174::bfish {
    struct BFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFISH>(arg0, 6, b"BFish", b"BlueFish", b"The marketing flow will be the same as the first one. I will burn trending and boost tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004659_14ccf21ff5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

