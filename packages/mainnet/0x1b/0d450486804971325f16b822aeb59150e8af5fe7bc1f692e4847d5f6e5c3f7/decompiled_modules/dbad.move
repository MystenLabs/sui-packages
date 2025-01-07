module 0x1b0d450486804971325f16b822aeb59150e8af5fe7bc1f692e4847d5f6e5c3f7::dbad {
    struct DBAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBAD>(arg0, 6, b"DBad", b"Down Bad", b"Down so bad you're on the SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/62a3a0bd_d029_4bda_9f9d_27e00ff74bea_9dbf7c8ae7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

