module 0x68ab99492fde2999376a7362c2c67eaea5709f929dfccfe1cae1c3f96c8ac86c::suimuray {
    struct SUIMURAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMURAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMURAY>(arg0, 6, b"SUIMURAY", b"Suimuray", b"Suimuray is a unique memecoin that combines the iconic humor of the troll face with the spirit of Japanese samurai, all supported by Sui blockchain technology. With a mission to spread laughter and strength", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016818_781fdfd0cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMURAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMURAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

