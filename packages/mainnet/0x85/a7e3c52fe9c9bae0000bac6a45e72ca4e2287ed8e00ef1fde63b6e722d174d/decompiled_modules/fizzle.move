module 0x85a7e3c52fe9c9bae0000bac6a45e72ca4e2287ed8e00ef1fde63b6e722d174d::fizzle {
    struct FIZZLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIZZLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIZZLE>(arg0, 6, b"Fizzle", b"FizzleSui", b"Sizzle or fizzle, $FIZZLE is always a win.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_061840110_a4276777ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIZZLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIZZLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

