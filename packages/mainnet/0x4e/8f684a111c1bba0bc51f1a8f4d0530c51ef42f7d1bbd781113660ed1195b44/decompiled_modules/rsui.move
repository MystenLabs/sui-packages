module 0x4e8f684a111c1bba0bc51f1a8f4d0530c51ef42f7d1bbd781113660ed1195b44::rsui {
    struct RSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSUI>(arg0, 9, b"RSUI", b"RoneldoSui", b"Suiiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df367f3c-14be-4c14-b0ec-d6c53c7313e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

