module 0x735cceca1c924f6ea60363ef8c2c7ad78b16e0ad0b511829a1f91724f5a67579::kitko {
    struct KITKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITKO>(arg0, 6, b"Kitko", b"Mr.Kitko", b"We are cooking for sure ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033461_f9c30f3013.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

