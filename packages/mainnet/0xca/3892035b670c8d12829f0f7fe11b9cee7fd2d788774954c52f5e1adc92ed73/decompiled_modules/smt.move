module 0xca3892035b670c8d12829f0f7fe11b9cee7fd2d788774954c52f5e1adc92ed73::smt {
    struct SMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMT>(arg0, 9, b"SMT", b"SMART", b"This token is built for #SUI Smart OG's.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a28f2581-b10c-4d5f-81a7-9e876abd1d87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

