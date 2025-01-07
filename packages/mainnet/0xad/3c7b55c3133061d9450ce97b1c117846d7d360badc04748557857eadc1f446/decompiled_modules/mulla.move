module 0xad3c7b55c3133061d9450ce97b1c117846d7d360badc04748557857eadc1f446::mulla {
    struct MULLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MULLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MULLA>(arg0, 6, b"MULLA", b"Mulla", b"Community owned, no team wallets. Golden checkmark on Twitter. Big community supporting. Let's make history.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240915010942_d63b7d65ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MULLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MULLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

