module 0x6ed30f2606fdf328716507f64067921f06ccec4b748bebb7223f3e31f4a621ea::elonsui {
    struct ELONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONSUI>(arg0, 6, b"Elonsui", b"Elonsuidoge", b"Elonsuidoge next to mars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5539_1222659dfd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

