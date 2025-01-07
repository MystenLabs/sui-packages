module 0x31cf8efcc50c9efc1b6790d93c0642443f55f155cec87a4ce2fa46070b77f7e4::holy {
    struct HOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLY>(arg0, 9, b"HOLY", b"Holy token", b"For Individuals who are living in a Christ like manner who can also share same crypto goals can be brought together by HOLY token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ead76154-ffde-4747-a9e9-e6d184b66166.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

