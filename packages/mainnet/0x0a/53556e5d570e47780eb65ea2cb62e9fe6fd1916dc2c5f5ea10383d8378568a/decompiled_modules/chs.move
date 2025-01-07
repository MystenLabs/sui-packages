module 0xa53556e5d570e47780eb65ea2cb62e9fe6fd1916dc2c5f5ea10383d8378568a::chs {
    struct CHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHS>(arg0, 9, b"CHS", b"Chess", b"game token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d0d2588e-7d17-4406-b06f-214be7a60c64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

