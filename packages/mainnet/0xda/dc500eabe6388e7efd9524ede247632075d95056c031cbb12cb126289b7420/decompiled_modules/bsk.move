module 0xdadc500eabe6388e7efd9524ede247632075d95056c031cbb12cb126289b7420::bsk {
    struct BSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSK>(arg0, 9, b"BSK", b"Blue Shark", b"Shark in ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1edcbac-df47-43b8-9852-c40d93b8638c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

