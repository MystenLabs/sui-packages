module 0x638f691be50d0891cd46ac961c6e9368256419304d90dc821cc8681117d429d::swif {
    struct SWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIF>(arg0, 6, b"sWIF", b"SuiWifHat", b"Dog wearing hat sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_22_35_30_a127bc2ad7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

