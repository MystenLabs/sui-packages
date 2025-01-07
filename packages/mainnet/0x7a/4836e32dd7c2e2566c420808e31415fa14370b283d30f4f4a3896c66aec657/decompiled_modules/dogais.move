module 0x7a4836e32dd7c2e2566c420808e31415fa14370b283d30f4f4a3896c66aec657::dogais {
    struct DOGAIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGAIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGAIS>(arg0, 6, b"DOGAIS", b"SUIBA AI DOG", b"FIRST AI DOG ON SUI CHAIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x2598c30330d5771ae9f983979209486ae26de875_d0f55bcfe8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGAIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGAIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

