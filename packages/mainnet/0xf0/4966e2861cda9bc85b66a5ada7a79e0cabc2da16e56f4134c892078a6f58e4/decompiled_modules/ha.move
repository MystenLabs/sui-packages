module 0xf04966e2861cda9bc85b66a5ada7a79e0cabc2da16e56f4134c892078a6f58e4::ha {
    struct HA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HA>(arg0, 9, b"HA", b"Hahaha", b"Meme fundlny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/642d143f-a63b-46da-85f9-12462718c61c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HA>>(v1);
    }

    // decompiled from Move bytecode v6
}

