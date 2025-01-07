module 0xd6534e0ac81bc8a8d347040d2202604f0e1192d4dd39722a79e706aa83fa827a::gb {
    struct GB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GB>(arg0, 9, b"GB", b"Good boy", b"Good job boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28dc830e-ba53-439a-838a-26bc3c435fc7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GB>>(v1);
    }

    // decompiled from Move bytecode v6
}

