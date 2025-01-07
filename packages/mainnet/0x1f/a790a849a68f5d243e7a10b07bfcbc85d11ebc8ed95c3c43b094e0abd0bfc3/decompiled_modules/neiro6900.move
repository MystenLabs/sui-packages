module 0x1fa790a849a68f5d243e7a10b07bfcbc85d11ebc8ed95c3c43b094e0abd0bfc3::neiro6900 {
    struct NEIRO6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO6900>(arg0, 6, b"Neiro6900", b"Neiro", b"$Neiro is a community-managed project with an emphasis on charity and doing only good everyday.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_1729356701010_351d0f0407.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

