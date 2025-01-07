module 0x88adb1322b9ffb137250f84e55b6deb514b1abd7b81481bf9c5b22f29019031b::popeyethesailorman {
    struct POPEYETHESAILORMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPEYETHESAILORMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPEYETHESAILORMAN>(arg0, 6, b"PopeyetheSailorMan", b"Popey", b"Popeye is an energetic man, as energetic as sui! Oh, by the way, Popeyes Chinese name is shuishou!Lfg!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241009114754_4b33e82617.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPEYETHESAILORMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPEYETHESAILORMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

