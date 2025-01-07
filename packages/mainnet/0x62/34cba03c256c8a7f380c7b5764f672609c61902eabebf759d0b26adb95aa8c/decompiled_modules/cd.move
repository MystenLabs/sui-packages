module 0x6234cba03c256c8a7f380c7b5764f672609c61902eabebf759d0b26adb95aa8c::cd {
    struct CD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CD>(arg0, 9, b"CD", b"CryptoDron", b"The token of a crypto bad investor who is looking for benefits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d2c24ac-ccb9-42a0-9469-34a4db590816.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CD>>(v1);
    }

    // decompiled from Move bytecode v6
}

