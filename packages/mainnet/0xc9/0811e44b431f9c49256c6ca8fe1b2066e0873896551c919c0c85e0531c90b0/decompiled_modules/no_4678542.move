module 0xc90811e44b431f9c49256c6ca8fe1b2066e0873896551c919c0c85e0531c90b0::no_4678542 {
    struct NO_4678542 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO_4678542, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO_4678542>(arg0, 9, b"NO_4678542", b"ILM", x"d09ed0bdd0b020d0b1d183d0b4d0b5d18220d0bfd180d0b0d0b2d0b8d182d18c20d0bcd0b8d180d0bed0bc20d0bfd0bed181d0bbd0b520d181d0bcd0b5d180d182d0b820d187d0b5d0bbd0bed0b2d0b5d187d0b5d181d182d0b2d0b020d0bdd0b020d0b7d0b5d0bcd0bbd0b52e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e97a8213-ca87-49c8-9c3c-ba68bd0be687.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO_4678542>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NO_4678542>>(v1);
    }

    // decompiled from Move bytecode v6
}

