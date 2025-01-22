module 0x6d5a52f35a0e0dcf7e188da733425ed2169fcb6c7dadb3238866de6474d327c5::uam {
    struct UAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: UAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UAM>(arg0, 9, b"UAM", b"Unicorn And Mermaid", b"$UAM The story of unicorn and mermaid is about to begin, are you ready ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfUQrAHsaMiejFHswo7v5Nk8PRayL12M1vrCUscWvW98i")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UAM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UAM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

