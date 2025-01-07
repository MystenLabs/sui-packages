module 0x1d9ad616ab1bef9fdcc6615333d53fd4bc38f9873e42a84c3bb3cc3be2886700::hawksui {
    struct HAWKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWKSUI>(arg0, 6, b"HAWKSUI", b"HAWK SUI", b"Hawk Tuah Comunnity welcome, we need a twitter! join the tele and lets set it up to fly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_12_fd3354b18d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAWKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

