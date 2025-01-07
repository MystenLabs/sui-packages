module 0x48118d6c8276b46bbb6e971d97553ff65c810d2f578b4b72d2cbd617ab60f4e9::cttl {
    struct CTTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTTL>(arg0, 9, b"CTTL", b"Cattle", b"Meme of Cattle ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a691b8f-8a5e-4563-9327-d442e3574905.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

