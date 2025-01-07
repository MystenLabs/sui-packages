module 0x928cb2c7f7a2aa58fb8b369540f386975109b86993aacf29315d6eb44d564705::vau {
    struct VAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAU>(arg0, 9, b"VAU", x"c490656e", b"Df", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3286a59-e1b6-4a9e-bbed-bd3f3d0b0ee8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

