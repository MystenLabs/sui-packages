module 0x5b080f3aee6a133d2951c6599719839650fb7092fd59740c819c698b80091f29::sumu {
    struct SUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMU>(arg0, 6, b"SUMU", b"SUMU THE BULL", b"Meet $SUMU, the meme bull on the Sui chain! Hes here to bring the bullish energy and good vibes to the blockchain world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sumu_90f7a43a3b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

