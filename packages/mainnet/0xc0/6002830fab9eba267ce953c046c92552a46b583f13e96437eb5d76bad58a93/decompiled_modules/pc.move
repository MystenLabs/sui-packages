module 0xc06002830fab9eba267ce953c046c92552a46b583f13e96437eb5d76bad58a93::pc {
    struct PC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PC>(arg0, 9, b"PC", b"Pc", b"Pc the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c3e622fd-1c34-4224-ba04-d39b0f31c4c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PC>>(v1);
    }

    // decompiled from Move bytecode v6
}

