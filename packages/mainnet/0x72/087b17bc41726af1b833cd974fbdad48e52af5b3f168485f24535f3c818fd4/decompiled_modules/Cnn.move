module 0x72087b17bc41726af1b833cd974fbdad48e52af5b3f168485f24535f3c818fd4::Cnn {
    struct CNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNN>(arg0, 9, b"CNN", b"Cnn", b"c of the NN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1669780523911110656/K9gaaM1g_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CNN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

