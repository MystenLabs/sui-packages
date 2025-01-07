module 0xf94c2ddbe1b41c6cd9207d321911b4cb0747177933c2bdb87a3f08ec92c29348::a12 {
    struct A12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A12>(arg0, 9, b"A12", b"Wawa", b"This is meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7653b1c5-2a5e-4583-b2bc-dc98e8f06d02.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A12>>(v1);
    }

    // decompiled from Move bytecode v6
}

