module 0x9e8a9e4a78f6de0ea91d1ff32a68e46017d38bfeee311893f0337be6db34e1d7::korp {
    struct KORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KORP>(arg0, 6, b"Korp", b"KorpDog", b"A KorpDog is your art pass to art airdrops, exclusive educational content and an awesome creative community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049426_0bf0516f3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KORP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KORP>>(v1);
    }

    // decompiled from Move bytecode v6
}

