module 0xa0be2aeea219bb1b0a48cf2b3750d0a74358c1b27d21631a264c5754239ba063::slaycat {
    struct SLAYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAYCAT>(arg0, 6, b"SLAYCAT", b"slayy cat on sui", b"omg slayy cat $SLAYCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_174644_353_010204075c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

