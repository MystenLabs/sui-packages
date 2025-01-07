module 0x25e66611e4c56203907764dd61fd07bd4985c0993f47dc03d0b1c7987e0c6573::zoro {
    struct ZORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORO>(arg0, 6, b"ZORO", b"ZORO ON SUI", x"496e2074686520746f776e206f6620517561636b76696c6c6520686527732061207374726169676874207570206c6567656e642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_Tw_X_Nh_S_400x400_05a01a843e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

