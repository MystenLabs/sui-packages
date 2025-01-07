module 0x98dc7eda78fe1e2bbfd4ee64df9888b824c25f2c90a4bbeca1dbae874a3892c1::usa {
    struct USA has drop {
        dummy_field: bool,
    }

    fun init(arg0: USA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USA>(arg0, 6, b"Usa", b"American sui", b"Do not ignore this movement.  This is very different, we take it from nothing to infinity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_U_U_U_U_U_U_U_U_U_U_U_U_U_U_09dd34d16c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USA>>(v1);
    }

    // decompiled from Move bytecode v6
}

