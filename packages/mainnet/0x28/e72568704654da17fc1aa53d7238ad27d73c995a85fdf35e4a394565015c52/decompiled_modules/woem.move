module 0x28e72568704654da17fc1aa53d7238ad27d73c995a85fdf35e4a394565015c52::woem {
    struct WOEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOEM>(arg0, 6, b"WOEM", b"MEMEOW", b"Maybe cat, maybe meow but of course its memeow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_24_16_27_53_46236709f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

