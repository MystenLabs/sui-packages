module 0xd23c0f0a20e0a5bd184a5460cd91401eddf1cc1b0afbb64865c719979fc5d28e::bucket {
    struct BUCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKET>(arg0, 6, b"BUCKET", b"Sui Bucket", b"Just a simple bucket holding all the Sui water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_based_bucketconcept_artart_gamecr_d91cd488_298e_49a1_9cef_55aabb8305e9_1_3d8e36deb8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

