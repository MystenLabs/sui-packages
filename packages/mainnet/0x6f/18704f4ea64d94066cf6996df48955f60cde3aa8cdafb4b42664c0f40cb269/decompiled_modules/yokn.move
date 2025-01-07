module 0x6f18704f4ea64d94066cf6996df48955f60cde3aa8cdafb4b42664c0f40cb269::yokn {
    struct YOKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOKN>(arg0, 9, b"YOKN", x"d0b3d0b6d182", b"gokbe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69b52282-9a1b-427e-8638-11e453d166e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

