module 0xfa6adb4df2ea1c4d21fe95b9d579a6adac2a1f83d749616bda25c011e4ac8e74::but {
    struct BUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUT>(arg0, 9, b"BUT", b"Sadbutrich", b"stay rich ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/588518be-87e0-4919-965e-18de1c22bc38.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

