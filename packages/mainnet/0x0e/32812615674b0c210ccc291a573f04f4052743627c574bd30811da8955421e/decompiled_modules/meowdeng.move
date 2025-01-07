module 0xe32812615674b0c210ccc291a573f04f4052743627c574bd30811da8955421e::meowdeng {
    struct MEOWDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWDENG>(arg0, 6, b"MeowDeng", b"SUIMEOWDENG", b"Cat szn + MOODENG = Meow Deng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018212_7f833e0a2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

