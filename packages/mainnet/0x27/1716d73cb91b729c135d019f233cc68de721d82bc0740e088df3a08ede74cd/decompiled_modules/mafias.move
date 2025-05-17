module 0x271716d73cb91b729c135d019f233cc68de721d82bc0740e088df3a08ede74cd::mafias {
    struct MAFIAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAFIAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAFIAS>(arg0, 6, b"MAFIAs", b"mafia", b"Dont you dare", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihh7odf2eelytum46tfsxcnu5yx6x6vjkdcwnl5djgar56efgz5ii")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAFIAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAFIAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

