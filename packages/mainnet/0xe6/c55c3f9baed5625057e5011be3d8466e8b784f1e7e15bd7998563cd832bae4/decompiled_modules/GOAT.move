module 0xe6c55c3f9baed5625057e5011be3d8466e8b784f1e7e15bd7998563cd832bae4::GOAT {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"Greatest Of All Token", b"GOAT", b"The ultimate meme coin for the GOATs of the internet! Whether you're a crypto legend, a meme lord, or just here for the ride, $GOAT is the token that celebrates the greatest of all time. Join the herd and let's moon together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/4RIC1VC8fQUlaidiR3CQu7cjlE5k9FOQX7AISYMcR6bobfFVA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

