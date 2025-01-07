module 0x4f7e7d76370a8a0f6614431c4371d1669c1d074c51815189f0d5b0d99e7e5ab1::morinzoo {
    struct MORINZOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORINZOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORINZOO>(arg0, 9, b"MORINZOO", b"Morinzo", b"just wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32b93995-ad9f-4c03-8108-dd7a25282c5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORINZOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORINZOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

