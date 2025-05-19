module 0xf0df25222f76e489b6019a5fa7d0195cc10e425dd6aae4b128ac430253eac37::shandshrui {
    struct SHANDSHRUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHANDSHRUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHANDSHRUI>(arg0, 6, b"SHANDSHRUI", b"SHRUI The Sandshrew of SUI", b"Alone in heat of sand, alone in the coldness of darkness. Sandshrui has emerge into the surface of $SUI. Splashing some sand!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicsdr4h73322kiy7a5hrdkfoj4pzdzrrclii2wkfwie2brorbe6km")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHANDSHRUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHANDSHRUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

