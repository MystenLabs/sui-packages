module 0x65a998c1c107bd54de9abac3805940ae0f83691f0d42d21211c53ce6c648dc11::susx {
    struct SUSX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSX>(arg0, 6, b"Susx", b"Sussex", b"A cat from britain, (Sussex): suisex ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0657_004596fa7a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSX>>(v1);
    }

    // decompiled from Move bytecode v6
}

