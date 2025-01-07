module 0x1a403e66025784afe96336c4e8b400fcb3b27900487be8e6450cd35211b5c67b::branl {
    struct BRANL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRANL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRANL>(arg0, 6, b"BRANL", b"BRAINLET", b"COMNUNMITY TAKEVOER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ei_0a2364ac4053dc2b55f5_17de0c0c46.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRANL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRANL>>(v1);
    }

    // decompiled from Move bytecode v6
}

