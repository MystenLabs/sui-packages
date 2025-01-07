module 0x4cb3857785993a8deb2afeb199b322608d9a46a74276b8a9c61d77216688c93::cappy {
    struct CAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPPY>(arg0, 6, b"CAPPY", b"Cappy", b"Chill with $CAPPY , be Cappy at the creek", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cappy_a7435c65cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

