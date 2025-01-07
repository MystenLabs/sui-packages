module 0xfeb9cb9c6b792f5bcae06fbea79b1970b243b12d08bac84cf1c3ffd1f6c3516d::ponko {
    struct PONKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKO>(arg0, 6, b"PONKO", b"Ponko Monkey", b"Feed me banannas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6e594624a83e866758e5b4e2d49bd8a3_792ccee2bc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

