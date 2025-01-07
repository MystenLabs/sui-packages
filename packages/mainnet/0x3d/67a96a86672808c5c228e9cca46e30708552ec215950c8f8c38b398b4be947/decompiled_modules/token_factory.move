module 0x3d67a96a86672808c5c228e9cca46e30708552ec215950c8f8c38b398b4be947::token_factory {
    struct TOKEN_FACTORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_FACTORY>(arg0, 2, b"BBDOG", b"BabyDog", b"BabyDog", 0x1::option::some<0x2::url::Url>(0x3d67a96a86672808c5c228e9cca46e30708552ec215950c8f8c38b398b4be947::icon::get_icon_url()), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_FACTORY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN_FACTORY>>(0x2::coin::mint<TOKEN_FACTORY>(&mut v2, 80000000000000000 * 0x3d67a96a86672808c5c228e9cca46e30708552ec215950c8f8c38b398b4be947::tools::pow(10, 2), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_FACTORY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

