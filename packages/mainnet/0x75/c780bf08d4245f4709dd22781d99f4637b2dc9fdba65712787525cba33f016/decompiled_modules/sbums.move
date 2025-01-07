module 0x75c780bf08d4245f4709dd22781d99f4637b2dc9fdba65712787525cba33f016::sbums {
    struct SBUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBUMS>(arg0, 6, b"SBUMS", b"BUMS", b"$BUMS is a true story of a man who changed his life to become rich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_23_24_38_b1d163f788.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBUMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

