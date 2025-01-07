module 0x9a14ba2766299596e627ae68275c56f7ca313b4d54eed6228b2bdb0628f22ad9::tpo {
    struct TPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPO>(arg0, 9, b"TPO", b"TRUMPO", b"Its", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32cf6c0a-9757-4ed5-a342-7344a974763b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

