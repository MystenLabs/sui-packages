module 0x2e026a0c6840e02dc4608f5b9e1c753b7941ed00d4b793914eef6c8e6aa7c1fa::tos {
    struct TOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOS>(arg0, 9, b"TOS", b"Trillion", b"Trillion Dollars On Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe3cc946-3675-4701-bbf2-5a49e3c26f16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

