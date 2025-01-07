module 0x3e080acdd49c4c2b48507a3efdb3f8d822345136148a2643d163ec74c714a5d6::weme {
    struct WEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEME>(arg0, 9, b"WEME", b"MEmecl3", b"WEME a meme culture one wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f47b637-952b-4e7c-a45f-b0c99bbf9f4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

