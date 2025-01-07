module 0x910bfe75be633449efd77f11c1ba9c4088258a08c6ebd8cd80da4d1df07d9713::thn {
    struct THN has drop {
        dummy_field: bool,
    }

    fun init(arg0: THN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THN>(arg0, 9, b"THN", b"TEHRAN", b"THN token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e444614-d3e4-4d1c-97e3-61cf709fc02a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THN>>(v1);
    }

    // decompiled from Move bytecode v6
}

