module 0xef974ed7bb31cbc31f0825274f311a2629001370da9a8e43ca55ac1108d3d7d9::tontonton {
    struct TONTONTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONTONTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONTONTON>(arg0, 9, b"TONTONTON", b"Ton on Ton", b"We are number one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4176c6e5-8e63-40c2-813a-fae40b966fe1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONTONTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONTONTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

