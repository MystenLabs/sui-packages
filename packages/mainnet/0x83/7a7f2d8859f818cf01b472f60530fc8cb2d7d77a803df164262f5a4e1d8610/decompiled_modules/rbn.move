module 0x837a7f2d8859f818cf01b472f60530fc8cb2d7d77a803df164262f5a4e1d8610::rbn {
    struct RBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBN>(arg0, 9, b"RBN", b"Ribbon", b"better get wrapping on this unusual shape, could be tricky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bfd9fcf-b217-45bd-bb54-b380fda4d980.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

