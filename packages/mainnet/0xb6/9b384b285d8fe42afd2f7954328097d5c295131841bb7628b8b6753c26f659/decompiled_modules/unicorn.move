module 0xb69b384b285d8fe42afd2f7954328097d5c295131841bb7628b8b6753c26f659::unicorn {
    struct UNICORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNICORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNICORN>(arg0, 6, b"UNICORN", b"Peaceful Unicorn Token", b"The Peaceful Unicorn is here to bring you the Spirit of Peace into your life as we will help provide a peaceful life to unwanted horses by offering 22% of this coin's proceeds to horse rescues and sanctuaries. In the website link you will find a list of horse rescues and organizations that we will be donating proceeds to and if you do not buy this coin, please consider donating directly to the websites listed! -The Peaceful Unicorn ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_21_170835_49b947fb1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNICORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNICORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

