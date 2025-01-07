module 0x352a4c4092a5a18a58b7a2c2fa3ea6ac46b8fdceae81a7515b13dbc7d3c4b8bc::bhippo {
    struct BHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHIPPO>(arg0, 6, b"BHIPPO", b"Baby Sui Hippo", b"Baby Hippo on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ellipse_15588_eae983afff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

