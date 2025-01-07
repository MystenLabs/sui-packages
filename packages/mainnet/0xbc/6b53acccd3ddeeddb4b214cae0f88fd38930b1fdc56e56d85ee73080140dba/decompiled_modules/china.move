module 0xbc6b53acccd3ddeeddb4b214cae0f88fd38930b1fdc56e56d85ee73080140dba::china {
    struct CHINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHINA>(arg0, 9, b"China", b"chinaaaaa", b"people republic of china", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ebf24f6fca32d0c239619ea6f842607ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHINA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHINA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

