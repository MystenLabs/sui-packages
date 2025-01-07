module 0x7b368674196473ba2d27c4b6243210057ced7b9fb68d0881e6201c9ecdef9aba::honse {
    struct HONSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONSE>(arg0, 6, b"HONSE", b"Honse", b"For those who identify with horses who have big torsos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/honse_648dcf3d3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

