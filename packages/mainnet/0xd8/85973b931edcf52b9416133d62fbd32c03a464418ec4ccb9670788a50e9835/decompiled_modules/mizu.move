module 0xd885973b931edcf52b9416133d62fbd32c03a464418ec4ccb9670788a50e9835::mizu {
    struct MIZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZU>(arg0, 6, b"MIZU", b"SUI IN JAPANESE", b"In Chinese, (siu) means \"WATER\". When translating from Chinese (siu) to Japanese, the kanji remains the same. However, in Japanese, it is pronounced $MIZU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mizu_eb8fff407d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

