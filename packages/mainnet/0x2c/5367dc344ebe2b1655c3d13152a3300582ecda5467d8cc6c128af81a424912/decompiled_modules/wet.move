module 0x2c5367dc344ebe2b1655c3d13152a3300582ecda5467d8cc6c128af81a424912::wet {
    struct WET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WET>(arg0, 6, b"Wet", b"Wet cat", b"Wet Cat is a silly, fun-loving cat who got caught in the rain! This token is all about her  shes full of love, laughter. https://t.me/catissowet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lkll_O_Cc_X_400x400_120487835c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WET>>(v1);
    }

    // decompiled from Move bytecode v6
}

