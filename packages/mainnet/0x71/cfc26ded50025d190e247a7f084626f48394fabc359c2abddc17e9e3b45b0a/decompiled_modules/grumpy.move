module 0x71cfc26ded50025d190e247a7f084626f48394fabc359c2abddc17e9e3b45b0a::grumpy {
    struct GRUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMPY>(arg0, 6, b"GRUMPY", b"Grumpy Cat", b"Tardar Sauce better known as Grumpy Cat, is a female cat and internet celebrity known for her angry and pouting facial expressions. $GRUMPY meme token on Sui Network Fair Launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/grumpy_cat_31abd9dcaf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

