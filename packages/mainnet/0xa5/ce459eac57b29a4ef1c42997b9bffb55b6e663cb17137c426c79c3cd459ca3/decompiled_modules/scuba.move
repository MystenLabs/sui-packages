module 0xa5ce459eac57b29a4ef1c42997b9bffb55b6e663cb17137c426c79c3cd459ca3::scuba {
    struct SCUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCUBA>(arg0, 6, b"SCUBA", b"BLUE SCUBA DOG", x"534355424120444956494e4720494e2054484520534541204f4345414e0a0a547769747465723a2068747470733a2f2f782e636f6d2f53637562615f5375690a54473a204053637562615375690a576562736974653a2068747470733a2f2f7363756261646f677375692e636f6d2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3665_330eabeecd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCUBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

