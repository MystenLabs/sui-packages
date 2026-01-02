module 0x6f1bb4b644b8af32c34747b8401b8adbde4ccd2169741ebfbc6f240a39ee620a::afc {
    struct AFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFC>(arg0, 6, b"AFC", b"Africoin", b"A token to Connect Africa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AFC_Logo_f234052a40.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

