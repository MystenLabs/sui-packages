module 0x35b90aef9b301fd0f2e5d8e099a3144da5773c09150b53595f9a6dd9629cf524::bnalley {
    struct BNALLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNALLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNALLEY>(arg0, 9, b"BNALLEY", b"BillizNall", b"Bnalley on Sui Ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b17d5352-db05-4f17-b2be-b86a579043d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNALLEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNALLEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

