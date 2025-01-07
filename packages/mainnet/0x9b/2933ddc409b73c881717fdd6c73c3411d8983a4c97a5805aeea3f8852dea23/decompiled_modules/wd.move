module 0x9b2933ddc409b73c881717fdd6c73c3411d8983a4c97a5805aeea3f8852dea23::wd {
    struct WD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WD>(arg0, 6, b"WD", b"Wrapped D0GE", b"Wrapped DoGE  Mem token on sui blockchain - $WD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_Po_P_Mhw_G_400x400_3ced433abd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WD>>(v1);
    }

    // decompiled from Move bytecode v6
}

