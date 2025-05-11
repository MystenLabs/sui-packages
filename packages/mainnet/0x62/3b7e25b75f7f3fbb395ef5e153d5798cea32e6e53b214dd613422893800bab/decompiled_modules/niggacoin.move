module 0x623b7e25b75f7f3fbb395ef5e153d5798cea32e6e53b214dd613422893800bab::niggacoin {
    struct NIGGACOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGACOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGACOIN>(arg0, 6, b"NiggaCoin", b"Niggacoin", b"Lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5248_f7615f1bd7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGACOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGACOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

