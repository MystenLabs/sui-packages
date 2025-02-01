module 0xe889d303de14347ae01071a51c65c3b501b140b61c0af79bce5ce733a4187908::cartoon {
    struct CARTOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTOON>(arg0, 6, b"CARTOON", b"Sui Cartoon", b"Cartoon coin. A story about a boy born on a UFO who wants to live on earth. An open source cartoon about UAP, Extraterrestials and disclousure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031991_0dd6b49ad6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARTOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARTOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

