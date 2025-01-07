module 0x16fc28212814df4dd180bed52634ff27c1abe9561c8aa976fc143fc80062cca4::soi {
    struct SOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOI>(arg0, 9, b"SOI", b"Soii", b"Soii token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f6dedab-bce6-4f53-8d0f-93c8b04c7d9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

