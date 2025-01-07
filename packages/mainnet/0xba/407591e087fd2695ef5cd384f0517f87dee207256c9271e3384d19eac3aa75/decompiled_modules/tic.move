module 0xba407591e087fd2695ef5cd384f0517f87dee207256c9271e3384d19eac3aa75::tic {
    struct TIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIC>(arg0, 6, b"TIC", b"Epileptic", x"4570696c6570746963206f6e205375690a0a240a0a0a4e4f20574542534954452c2057652063726561746520582040203130304b204d430a5761726e696e673a205365697a75726520616865616421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0249_b2c6bb2750.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

