module 0xcf01f3389da4ad791cbf5e7b40ba516f0216c098f39562dd60308d524b9625e7::mokisui {
    struct MOKISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOKISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOKISUI>(arg0, 6, b"Mokisui", b"MokimemeSUI", b"Welcome to SuiMoki ($MOKI), where the thrill of the ride meets the excitement of cryptocurrency. MokiMeme brings a unique fusion of high-octane action and cutting-edge digital finance. Whether you're an adrenaline junkie or a crypto enthusiast, $MOKI is your ticket to a world where cars collide, fortunes are made, and the arena is always buzzing with the next BIG WIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036294_77b6de35af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOKISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOKISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

