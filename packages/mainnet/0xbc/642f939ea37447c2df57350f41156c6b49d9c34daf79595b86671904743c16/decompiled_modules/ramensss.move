module 0xbc642f939ea37447c2df57350f41156c6b49d9c34daf79595b86671904743c16::ramensss {
    struct RAMENSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAMENSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAMENSSS>(arg0, 6, b"Ramensss", b"Ramen", x"52616d656e206973206f6e2061206d697373696f6e20746f206265207468652076657279206669727374207375636365737366756c20646f67206f6e207375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Q_Jcpa7mt_400x400_c069ab5db0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAMENSSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAMENSSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

