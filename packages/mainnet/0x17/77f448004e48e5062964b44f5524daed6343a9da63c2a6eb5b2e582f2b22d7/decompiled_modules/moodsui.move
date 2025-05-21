module 0x1777f448004e48e5062964b44f5524daed6343a9da63c2a6eb5b2e582f2b22d7::moodsui {
    struct MOODSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODSUI>(arg0, 9, b"Moodsui", b"MOODENGSUI", b"Moodengsuimood", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fd8596b9b72e54fb60c651f6e72bafcdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

