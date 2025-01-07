module 0xd08e134b6d0388a3f77eda0c3b097a64fb45fa17dbf656e45edfba029622d930::bucket {
    struct BUCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKET>(arg0, 6, b"BUCKET", b"Sui Bucket", b"$BUCKET holds everything you need in the Sui Network. Its simple, its handy, and its ready to catch all your gains. Dont let anything slip through!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_based_bucketconcept_artart_gamecr_1c49b3c1_ac54_40e8_b3cb_7568bd383a07_c900513b47.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

