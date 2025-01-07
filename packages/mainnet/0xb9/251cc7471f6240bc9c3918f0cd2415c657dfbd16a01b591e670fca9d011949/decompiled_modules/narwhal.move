module 0xb9251cc7471f6240bc9c3918f0cd2415c657dfbd16a01b591e670fca9d011949::narwhal {
    struct NARWHAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NARWHAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NARWHAL>(arg0, 6, b"Narwhal", b"narwhal", b"Narwhal on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_3cb95a34f3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NARWHAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NARWHAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

