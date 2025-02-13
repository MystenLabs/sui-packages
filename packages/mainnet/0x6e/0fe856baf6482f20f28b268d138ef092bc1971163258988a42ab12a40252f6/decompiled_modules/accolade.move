module 0x6e0fe856baf6482f20f28b268d138ef092bc1971163258988a42ab12a40252f6::accolade {
    struct ACCOLADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACCOLADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACCOLADE>(arg0, 9, b"ACCOLADE", b"Akolade1", b" Coin with long life ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e8dfae2-6ab7-4338-b394-8af11fdf689d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACCOLADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACCOLADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

