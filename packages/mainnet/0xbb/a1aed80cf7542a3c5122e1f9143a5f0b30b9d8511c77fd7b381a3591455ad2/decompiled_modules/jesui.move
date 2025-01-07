module 0xbba1aed80cf7542a3c5122e1f9143a5f0b30b9d8511c77fd7b381a3591455ad2::jesui {
    struct JESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUI>(arg0, 6, b"JeSui", b"JEPESUI", x"0a4a455045207265766f6c7574696f6e20616e6420657870657269656e6365206d656d65206d61676963206c696b65206e65766572206265666f72652120205374616b6520796f757220636c61696d2c2062652070617274206f6620686973746f72792c20616e64206c657420746865204a455045207370697269742074616b6520796f7520746f206e6577206865696768747321200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241011_135025_812_9f732661a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

