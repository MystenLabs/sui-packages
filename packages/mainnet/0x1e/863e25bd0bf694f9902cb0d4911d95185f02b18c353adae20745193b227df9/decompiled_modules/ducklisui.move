module 0x1e863e25bd0bf694f9902cb0d4911d95185f02b18c353adae20745193b227df9::ducklisui {
    struct DUCKLISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKLISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKLISUI>(arg0, 6, b"DUCKLISUI", b"DUCK A LISA", b"https://t.me/+0TeXLVlP_aM3YTQ1 Duck-a-lisa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_17_43_26_05d144250a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKLISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKLISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

