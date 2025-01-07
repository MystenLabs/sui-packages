module 0x8a18ddf4bc51d45218e8a91278667ef2db6e01399c2116787ee42935d286b14e::snap {
    struct SNAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAP>(arg0, 6, b"SNAP", b"SnapCoin", b"$SNAP ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fh_Az8_CA_3_400x400_7f232cd031.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

