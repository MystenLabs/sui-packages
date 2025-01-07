module 0xab62d9218ae9c1fd3633ff8b10ffb277d7600dfabd9f43e89ad248ed7a7366a5::supersui {
    struct SUPERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERSUI>(arg0, 6, b"SuperSui", b"Super Suiyan", b"Kame-Hame-SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3487_c6a137952f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

