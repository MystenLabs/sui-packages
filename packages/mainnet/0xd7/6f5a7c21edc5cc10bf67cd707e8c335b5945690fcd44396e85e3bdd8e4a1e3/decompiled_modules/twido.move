module 0xd76f5a7c21edc5cc10bf67cd707e8c335b5945690fcd44396e85e3bdd8e4a1e3::twido {
    struct TWIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIDO>(arg0, 6, b"TWIDO", b"Twister the Dog", b"$TWIDO the brilliant dog thats wagging its way into TON world! Woof woof!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3488_d7428684eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

