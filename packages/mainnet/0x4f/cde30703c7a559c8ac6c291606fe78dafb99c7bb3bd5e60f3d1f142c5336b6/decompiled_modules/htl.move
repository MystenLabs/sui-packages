module 0x4fcde30703c7a559c8ac6c291606fe78dafb99c7bb3bd5e60f3d1f142c5336b6::htl {
    struct HTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTL>(arg0, 9, b"HTL", b"besthotel", b"Inspired by the world of hospitality and travel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b930db29-6833-492d-9fb3-4b942aa07981.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

