module 0x922104b9724815d48622293944ec22c7b2c411dd66689d9682a701ae1c06d6e1::nerea {
    struct NEREA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEREA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEREA>(arg0, 6, b"NEREA", b"NEREA RAY GIRL", b"The wife of $RAY ROMA is comming!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_tulo_1aa810d193.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEREA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEREA>>(v1);
    }

    // decompiled from Move bytecode v6
}

