module 0xd7bed1b25f03b872c51ffcc5aa666856f9d802e925c14c4d46aa573898f6a81f::sdsdsd {
    struct SDSDSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDSDSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDSDSD>(arg0, 9, b"SDSDSD", b"AAAA", b"SDFSDFSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/042d5464-d214-4cb3-bfb3-7c588245ef49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDSDSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDSDSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

