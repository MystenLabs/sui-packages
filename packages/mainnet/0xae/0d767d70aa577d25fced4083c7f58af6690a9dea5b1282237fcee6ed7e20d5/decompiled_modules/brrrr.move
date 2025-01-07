module 0xae0d767d70aa577d25fced4083c7f58af6690a9dea5b1282237fcee6ed7e20d5::brrrr {
    struct BRRRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRRRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRRRR>(arg0, 6, b"Brrrr", b"Suiwming Dawg", b"cold cold cold cold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiwming_dog_5d41b1d29d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRRRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRRRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

