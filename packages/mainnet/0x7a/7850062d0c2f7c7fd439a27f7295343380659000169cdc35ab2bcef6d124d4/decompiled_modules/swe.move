module 0x7a7850062d0c2f7c7fd439a27f7295343380659000169cdc35ab2bcef6d124d4::swe {
    struct SWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWE>(arg0, 9, b"SWE", b"SHIWE", b"The meme project was inspired by shiba and wewe, bringing community excitement with humorous meme tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9adcd993-2b15-4bce-b36a-f08d0ac55015.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

