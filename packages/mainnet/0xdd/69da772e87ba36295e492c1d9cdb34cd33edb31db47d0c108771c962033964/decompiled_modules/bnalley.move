module 0xdd69da772e87ba36295e492c1d9cdb34cd33edb31db47d0c108771c962033964::bnalley {
    struct BNALLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNALLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNALLEY>(arg0, 9, b"BNALLEY", b"Billiznall", b"Bnalley on Sui BLOCKCHAIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5a159fc-7d7e-4f5c-9a5a-3de58e38e547.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNALLEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNALLEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

