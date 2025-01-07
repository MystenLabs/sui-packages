module 0x7a158faea1be0709dc473f943529b98be445b8e58eacf6080862fe1f7d70076::txc {
    struct TXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TXC>(arg0, 9, b"TXC", b"Taxic", b"A token for big price explosions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e1b489e-4453-4766-a1a8-60dc1cc6bbd5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

