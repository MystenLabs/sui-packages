module 0x8ceda71a2d7eb6f20ef599175d6b8b34f2437a9c34e1e80c27ad711783c5d5dd::trumpme {
    struct TRUMPME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPME>(arg0, 9, b"TRUMPME", b"Trump meme", b"Good meme Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9199b48-687e-4989-9afa-fee4658653e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPME>>(v1);
    }

    // decompiled from Move bytecode v6
}

