module 0xc68b7d951f3ec363374cf1ac20c54caef920e5a4dac9a62e43180cfda3311058::dewe {
    struct DEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEWE>(arg0, 6, b"Dewe", b"e33fdd", b"wewefsdfdsfdsf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_a_2024_09_22_00_48_35_9ccd6dbd28.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

