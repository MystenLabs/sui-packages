module 0xc7710f7834fbc3e59a236bd1d4098997d383b2bf737f0f18cdb15d5562b3ab08::emf {
    struct EMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMF>(arg0, 6, b"EMF", b"Elon Meme F", b"Elon meme hype the future ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004430_f5658aa35d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

