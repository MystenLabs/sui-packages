module 0x67d090273cb398abc9bcbbad5f701fdf168bf7040188ac1ebab27dac2dd04fe4::xjx {
    struct XJX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XJX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XJX>(arg0, 9, b"XJX", b"Candies ", b"Xkxkc is a great game and I ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/734fe62f-5df9-4d3c-bdf0-17ee11e31371.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XJX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XJX>>(v1);
    }

    // decompiled from Move bytecode v6
}

