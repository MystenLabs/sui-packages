module 0xcc13ae4bb775583b8c374a9604959dfee99efe3ed60c715b72d000b41ce03331::suilitsflix {
    struct SUILITSFLIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILITSFLIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILITSFLIX>(arg0, 6, b"SUILITSFLIX", b"SUILITS", b"one of the biggest series about lawyers is now on SUI! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_201246970_4d60931e07.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILITSFLIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILITSFLIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

