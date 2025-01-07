module 0x19295264d325aad8c2d37089988b8b8fec929675f6613a21cf95c29ee5f259ec::tcat {
    struct TCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCAT>(arg0, 9, b"TCAT", b"Trade Mew", b"The Tranding Mew Mew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/532a7918-6030-4d51-b831-a28876068cc8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

