module 0x4d311522bc8cc11cd075f78224126c2ff2952d1ad9d3f43aec3767f0747c581e::catqr {
    struct CATQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATQR>(arg0, 9, b"CATQR", b"Whiskers the cat on sui", b"In a quaint little cafe, nestled amidst the bustling city, there lived a peculiar waiter named Whiskers. No, Whiskers wasn't your average human waiter. In fact, he wasn't human at all. He was a sleek, black cat with a penchant for serving tea and pastries.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c501d4adb9c4cbcc1a780c1881bdf54bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATQR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATQR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

