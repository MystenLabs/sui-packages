module 0xe936ba2b6518bf91fc2b77b8f6b470c337d6ee90243eec73e2865c8429f48bf7::dk {
    struct DK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DK>(arg0, 9, b"DK", b"DIk ", b"Mem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4d6b509-c7b5-426e-99d7-5d414874d04c-IMG_7358.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DK>>(v1);
    }

    // decompiled from Move bytecode v6
}

