module 0x872615fc71d98ff209e7722b33eaae383f299f2dfae3c72121bdafdf53735061::assn {
    struct ASSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSN>(arg0, 9, b"ASSN", b"ASSASSIN", b"ASSASSIN COIN IS HERE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8340a096-d826-413e-8795-5a46f7e352e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

