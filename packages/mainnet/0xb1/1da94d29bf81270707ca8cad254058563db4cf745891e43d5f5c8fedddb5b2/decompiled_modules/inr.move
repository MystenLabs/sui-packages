module 0xb11da94d29bf81270707ca8cad254058563db4cf745891e43d5f5c8fedddb5b2::inr {
    struct INR has drop {
        dummy_field: bool,
    }

    fun init(arg0: INR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INR>(arg0, 9, b"INR", b"RUPEE", b"This token is an intro of Indian Meme token to Crypto World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49855950-98ca-4d0a-b1f7-4b83a5ad11f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INR>>(v1);
    }

    // decompiled from Move bytecode v6
}

