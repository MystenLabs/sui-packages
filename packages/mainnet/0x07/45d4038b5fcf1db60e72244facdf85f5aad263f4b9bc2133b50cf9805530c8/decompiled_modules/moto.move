module 0x745d4038b5fcf1db60e72244facdf85f5aad263f4b9bc2133b50cf9805530c8::moto {
    struct MOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTO>(arg0, 6, b"MOTO", b"MOTO MOTO", b"Moto Moto is an animated hippo and ladies' man featured in Madagascar: Escape 2 Africa that is known for his flirtatious attitude and handsomeness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ace_a4ad071ca8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

