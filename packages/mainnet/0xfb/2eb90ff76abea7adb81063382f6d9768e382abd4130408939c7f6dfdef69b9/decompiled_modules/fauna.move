module 0xfb2eb90ff76abea7adb81063382f6d9768e382abd4130408939c7f6dfdef69b9::fauna {
    struct FAUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUNA>(arg0, 6, b"Fauna", b"Faunaa", b"Faunaa meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739003635068.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUNA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAUNA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

