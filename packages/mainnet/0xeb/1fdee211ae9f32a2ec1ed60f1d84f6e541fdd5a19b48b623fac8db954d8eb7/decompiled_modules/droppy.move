module 0xeb1fdee211ae9f32a2ec1ed60f1d84f6e541fdd5a19b48b623fac8db954d8eb7::droppy {
    struct DROPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPPY>(arg0, 6, b"DROPPY", b"Droppy On sui", b"$DROPPY On sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241002_031749_8e13394dfc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

