module 0xf68957f1e0dcf14d51e27297bb41a59eec9c866ee9e2fee6f23e591716293903::fsa {
    struct FSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSA>(arg0, 9, b"FSA", b"SA", b"DSG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35809371-2265-4412-a1c8-0e1add602146.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

