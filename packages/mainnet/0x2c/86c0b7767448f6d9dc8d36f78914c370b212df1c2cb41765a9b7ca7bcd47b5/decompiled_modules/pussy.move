module 0x2c86c0b7767448f6d9dc8d36f78914c370b212df1c2cb41765a9b7ca7bcd47b5::pussy {
    struct PUSSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSY>(arg0, 9, b"PUSSY", b"PUSSY CAT", x"507572656c792064656469636174656420746f2074686520676c6f7279206f6620612070757373792063617420f09f8c9a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c742521a-41a7-4307-bbcb-36b05ceb62a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUSSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

