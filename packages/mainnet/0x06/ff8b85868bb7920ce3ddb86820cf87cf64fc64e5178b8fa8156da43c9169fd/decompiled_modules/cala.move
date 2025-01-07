module 0x6ff8b85868bb7920ce3ddb86820cf87cf64fc64e5178b8fa8156da43c9169fd::cala {
    struct CALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CALA>(arg0, 6, b"CALA", b"Singing Cat Cala", b"Cala delighted us with her beautiful voice. She has over 10 million views and 500,000 followers on Instagram and YouTube. Rip Cala.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cala_the_I_Go_Meow_Cat_has_Died_0603241_1_bab997626d1a489da8c7a4d2b6217b67_ac716b5565.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

