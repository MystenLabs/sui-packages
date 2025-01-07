module 0x48ff72b8fc80353f49bff7336331d3d70dc97f94c8a98d4a4e7773dc77319084::bimp {
    struct BIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIMP>(arg0, 6, b"BIMP", b"BabyChimp", b"Never has any great kingdom strive without an army. Bimp will be build a strong army to include the brightest and soundest mind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731015553463.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

