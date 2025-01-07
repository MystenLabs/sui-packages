module 0x4e3dd66efbf3f17deeb8e78992bcd7ba86140b7b1c53230aeb578a8d4aee55a::usd {
    struct USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USD>(arg0, 8, b"USD", b"USD", b"world currency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bkimg.cdn.bcebos.com/pic/503d269759ee3d6d55fbb529575d7a224f4a21a470b4?x-bce-process=image/format,f_auto/watermark,image_d2F0ZXIvYmFpa2UyNzI,g_7,xp_5,yp_5,P_20/resize,m_lfit,limit_1,h_1080")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

