module 0x1003f3cc881040bd76da5831d51cac92db88adc54d5d83a97ad092bacaf0a11d::sess {
    struct SESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SESS>(arg0, 6, b"Sess", b"SS", b"sssssssssss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moonlitebot_x_rachop_860a539a0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

