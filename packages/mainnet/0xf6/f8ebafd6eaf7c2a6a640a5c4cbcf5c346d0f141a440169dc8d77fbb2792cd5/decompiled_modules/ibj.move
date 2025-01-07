module 0xf6f8ebafd6eaf7c2a6a640a5c4cbcf5c346d0f141a440169dc8d77fbb2792cd5::ibj {
    struct IBJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBJ>(arg0, 9, b"IBJ", b"IBJAAD ", b"IBJAAD IS VERSATILE AND HERE TO STAY, HUMAN PROTOCOL SERVICE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2d3fa53-5efe-49f0-aff8-01d586baa986.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IBJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

