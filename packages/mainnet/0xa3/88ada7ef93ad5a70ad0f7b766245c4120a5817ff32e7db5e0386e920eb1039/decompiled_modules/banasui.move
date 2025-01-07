module 0xa388ada7ef93ad5a70ad0f7b766245c4120a5817ff32e7db5e0386e920eb1039::banasui {
    struct BANASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANASUI>(arg0, 6, b"Banasui", b"A banana on SUI", b"Yes, it's just a banana. That's all. Let's see how can it go.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731050080398.31")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

