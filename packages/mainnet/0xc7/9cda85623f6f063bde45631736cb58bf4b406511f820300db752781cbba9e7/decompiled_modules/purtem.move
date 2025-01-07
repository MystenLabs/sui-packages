module 0xc79cda85623f6f063bde45631736cb58bf4b406511f820300db752781cbba9e7::purtem {
    struct PURTEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURTEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURTEM>(arg0, 9, b"PURTEM", b"purteme", b"community driven.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9b7d861-266a-4c0c-87ed-73601fd27419.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURTEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PURTEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

