module 0xdf5fc66e780aa6325ca8d8396bf42f66b107ccf9ac99a935324a11d1e8c495e::turtello {
    struct TURTELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTELLO>(arg0, 6, b"TURTELLO", b"Turtello", b"$TURTELLO is a playful and spirited meme coin on the Sui blockchain, inspired by a happy and fun-loving turtle that thrives on memes, laughter, and sports. Loved by the Sui community, Turtello brings joy and energy, embracing a vibrant jungle lifestyle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Turtlle_Profile_eeb1fe03b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTELLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTELLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

