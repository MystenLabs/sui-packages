module 0x6973c1ae4a9a6b0638f0575b956258809762c314aba657ea09b810432a32493e::mjr {
    struct MJR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MJR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MJR>(arg0, 9, b"MJR", b"Major ", b"To boost mining ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c30dbbb4-fa9f-4548-9120-b109f6f63d2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MJR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MJR>>(v1);
    }

    // decompiled from Move bytecode v6
}

