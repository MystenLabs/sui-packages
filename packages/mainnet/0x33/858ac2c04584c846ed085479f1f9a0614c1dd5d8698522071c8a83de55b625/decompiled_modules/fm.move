module 0x33858ac2c04584c846ed085479f1f9a0614c1dd5d8698522071c8a83de55b625::fm {
    struct FM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FM>(arg0, 6, b"FM", b"fishies Maximus", b"the Goatseus Maximus killer on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_abdec526bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FM>>(v1);
    }

    // decompiled from Move bytecode v6
}

