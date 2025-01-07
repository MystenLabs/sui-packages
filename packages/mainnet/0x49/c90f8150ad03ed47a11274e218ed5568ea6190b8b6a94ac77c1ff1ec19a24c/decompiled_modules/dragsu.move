module 0x49c90f8150ad03ed47a11274e218ed5568ea6190b8b6a94ac77c1ff1ec19a24c::dragsu {
    struct DRAGSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGSU>(arg0, 6, b"DragSu", b"Blue Eye Sui Dragon", b"Blue Eyes White Dragon Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_eye_9dbedf9233.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

