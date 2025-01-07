module 0xcb50d15ab32ba01b96f1d655c8db06d761f005a0b1b3d58b4bc89461949c72f8::ilmn2 {
    struct ILMN2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILMN2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILMN2>(arg0, 9, b"ILMN2", b"Illuminad2", b"This is a memecoin inspired by people who have reached a high level of consciousness, people who are in the process of awakening consciousness, ENLIGHTENED people.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8eda4dc-80a3-436f-9ef6-8702c9bbf49a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILMN2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ILMN2>>(v1);
    }

    // decompiled from Move bytecode v6
}

