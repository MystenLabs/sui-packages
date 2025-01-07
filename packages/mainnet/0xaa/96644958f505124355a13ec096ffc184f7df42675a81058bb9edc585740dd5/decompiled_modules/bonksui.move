module 0xaa96644958f505124355a13ec096ffc184f7df42675a81058bb9edc585740dd5::bonksui {
    struct BONKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKSUI>(arg0, 9, b"BONKSUI", b"Bonk", b"Meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb2f5b07-4868-4e0e-884a-5a74ddce1515.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

