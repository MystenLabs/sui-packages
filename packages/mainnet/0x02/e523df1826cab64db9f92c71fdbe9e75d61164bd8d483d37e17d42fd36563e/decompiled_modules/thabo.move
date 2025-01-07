module 0x2e523df1826cab64db9f92c71fdbe9e75d61164bd8d483d37e17d42fd36563e::thabo {
    struct THABO has drop {
        dummy_field: bool,
    }

    fun init(arg0: THABO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THABO>(arg0, 6, b"THABO", b"New Born Pygmy Hippo", b"Welcome to the world, THABO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0818_9449749c46.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THABO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THABO>>(v1);
    }

    // decompiled from Move bytecode v6
}

