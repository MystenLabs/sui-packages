module 0xfb247466bb43aaedade1c90581b2c37312fe027c44489461906ec9dc00aaec26::icon {
    struct ICON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICON>(arg0, 6, b"ICON", b"SUI ICON", b"SUI Laugh ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tong_hop_hinh_anh_mat_cuoi_toe_toet_7496cd8cc6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICON>>(v1);
    }

    // decompiled from Move bytecode v6
}

