module 0x6ca495ec19b2096a3e1fa9cefac024e9fe9712675f2cabc7f2c02d0b7b202211::Tag_Test {
    struct TAG_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAG_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAG_TEST>(arg0, 9, b"TAG", b"Tag Test", b"tag testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1933822734141734912/t0EN4YYL_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAG_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAG_TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

