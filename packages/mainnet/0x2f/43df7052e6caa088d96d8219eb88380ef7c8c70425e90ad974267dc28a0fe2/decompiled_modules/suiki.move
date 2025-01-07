module 0x2f43df7052e6caa088d96d8219eb88380ef7c8c70425e90ad974267dc28a0fe2::suiki {
    struct SUIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKI>(arg0, 6, b"SUIKI", b"SUIKI on SUI", b"Quack quack!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_da_A_cran_2024_10_04_183721_e288a19d1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

