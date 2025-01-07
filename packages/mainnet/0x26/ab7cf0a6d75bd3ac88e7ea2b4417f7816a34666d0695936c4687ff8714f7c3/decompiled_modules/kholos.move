module 0x26ab7cf0a6d75bd3ac88e7ea2b4417f7816a34666d0695936c4687ff8714f7c3::kholos {
    struct KHOLOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHOLOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHOLOS>(arg0, 9, b"KHOLOS", b"Kholis Vi", b"November ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4cab05c2-025d-4c98-b4c5-334f96168fd2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHOLOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHOLOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

