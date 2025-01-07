module 0x8dfca5c7769e3106642a8855b8e9c124b7f8b49a25597732f9f9a40900cb43b3::pda {
    struct PDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDA>(arg0, 9, b"PDA", b"panda", b"Lazy and tired, of course, on the contrary", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/735f7a07-e3d8-40f4-924e-0f2b9552a977.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

