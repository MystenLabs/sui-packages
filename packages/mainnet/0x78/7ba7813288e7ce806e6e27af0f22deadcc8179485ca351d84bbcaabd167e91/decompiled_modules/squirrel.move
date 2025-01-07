module 0x787ba7813288e7ce806e6e27af0f22deadcc8179485ca351d84bbcaabd167e91::squirrel {
    struct SQUIRREL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRREL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRREL>(arg0, 6, b"SQUIRREL", b"SQUIRREL ", b"This is a meme from six years ago. At the time, nobody knew what it meant.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731459825406.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIRREL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRREL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

