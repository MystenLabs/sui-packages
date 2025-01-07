module 0xc53db755dcabd368144d5615e83f2a5b380944713e818be937a0491422d2523e::doogle {
    struct DOOGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOGLE>(arg0, 6, b"DOOGLE", b"Doogle", b"Doogle is a cartoon character made by Matt Furie on 2018. The purpose of the character is to entertain and make people smile.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yellow_dog_w_text_dbd15149c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

