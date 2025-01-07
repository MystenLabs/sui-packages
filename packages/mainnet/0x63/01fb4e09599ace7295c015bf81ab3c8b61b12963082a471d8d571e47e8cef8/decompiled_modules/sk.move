module 0x6301fb4e09599ace7295c015bf81ab3c8b61b12963082a471d8d571e47e8cef8::sk {
    struct SK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SK>(arg0, 6, b"SK", b"Sui King", b"Sui is memecoin on sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000316845_65a495f65d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SK>>(v1);
    }

    // decompiled from Move bytecode v6
}

