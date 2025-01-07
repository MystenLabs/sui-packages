module 0x5ac050b0b203503812593ed80297277b26eb4e311c7d612cf59662317c70507d::hoh {
    struct HOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOH>(arg0, 9, b"HOH", b"Hogoho", b"Ho ho ho ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d85e214-0ed0-4036-afd5-c7f67f63fffe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOH>>(v1);
    }

    // decompiled from Move bytecode v6
}

