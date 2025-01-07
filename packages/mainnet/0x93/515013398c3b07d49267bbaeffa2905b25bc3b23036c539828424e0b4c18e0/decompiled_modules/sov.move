module 0x93515013398c3b07d49267bbaeffa2905b25bc3b23036c539828424e0b4c18e0::sov {
    struct SOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOV>(arg0, 9, b"SOV", b"Solve", b"A token with solutions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b165ce78-ed17-4394-a8f8-73955c7857f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOV>>(v1);
    }

    // decompiled from Move bytecode v6
}

