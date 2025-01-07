module 0xfaae0cfe7857ded919a25df1ca66c3b4b4dae9ad9a90aee25f0fa0f4a2ab72c8::cens {
    struct CENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CENS>(arg0, 9, b"CENS", b"CENSUI", b"One for all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ab45a8f-d6c9-4e5d-83bd-0b37f3416c7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

