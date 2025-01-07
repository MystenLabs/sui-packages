module 0x7398dd10e1edf27bd9e50d3a5482f7cea4f1008ace2d407df13d945d1f62019e::px {
    struct PX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PX>(arg0, 9, b"PX", b"Not Pixel", b"Not Pixel is a Telegram Mini Project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad1311a3-8348-4f25-b687-537f938ad70c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PX>>(v1);
    }

    // decompiled from Move bytecode v6
}

