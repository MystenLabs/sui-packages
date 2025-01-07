module 0x94e40b0adc6b38217f7747f67ca43ceeeeb360466546a2aaf4fa3759d668be79::suuflex {
    struct SUUFLEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUUFLEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUUFLEX>(arg0, 6, b"SUUFLEX", b"Suuflex", b"Journey of SUU to the Suuuuii ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suu_f9cbac09d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUUFLEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUUFLEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

