module 0x6b7073cda9532390ff70f4c9f661cfbcaa5c776516c235caccd5c3dded201bbc::mewsui {
    struct MEWSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWSUI>(arg0, 9, b"MEWSUI", b"LFG", b"Mew mew mew !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31886846-be6b-4ff0-b828-5f5d1a38e0ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

