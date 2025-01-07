module 0xf06b5fd1debf379636adc6d99d5ca2ad38b5112cff45f47ca9d6bdbc37f542f2::memek {
    struct MEMEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK>(arg0, 9, b"MEMEK", b"Airdrop", b"SPESIAL AIRDROP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a917f8c4-44a0-47a7-ae0c-c4ca0beaa213.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

