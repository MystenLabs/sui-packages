module 0x1924f8d7ffdc723d83cc30295eaeec7029b3ef6a057e035193f3d474f4996ab9::grinchsui {
    struct GRINCHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRINCHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINCHSUI>(arg0, 6, b"Grinchsui", b"The grinch", b"Grinch...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000907956_9cc2d1fa14.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINCHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRINCHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

