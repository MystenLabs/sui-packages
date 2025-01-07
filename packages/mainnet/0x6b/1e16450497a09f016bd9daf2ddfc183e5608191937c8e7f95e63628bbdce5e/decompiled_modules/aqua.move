module 0x6b1e16450497a09f016bd9daf2ddfc183e5608191937c8e7f95e63628bbdce5e::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 6, b"AQUA", b"aqua", b"Aqua is a playful and creative concept that draws inspiration from the popular anime series \"KonoSuba: God's Blessing on This Wonderful World!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NEW_BUY_2_183e319a60.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

