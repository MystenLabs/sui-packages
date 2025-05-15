module 0x2f1da796914afd796c9ae3c669f5359636cc42239c9e6450a099397b44618fca::mato {
    struct MATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATO>(arg0, 6, b"Mato", b"Mato the Mouse", b"Mato the Mouse is Rato the Rat's friend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiapozuw7gapjluw6bjkesvb2k24j6ejug5hvocpiu4fv6abw44nui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MATO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

