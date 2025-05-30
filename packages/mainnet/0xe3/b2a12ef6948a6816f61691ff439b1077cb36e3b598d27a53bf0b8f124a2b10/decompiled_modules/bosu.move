module 0xe3b2a12ef6948a6816f61691ff439b1077cb36e3b598d27a53bf0b8f124a2b10::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSU>(arg0, 6, b"BOSU", b"Final Bosu", b"aka BOSU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibbelrm5pshupggp7smawff56jtfqb62b3ahcvcglgnnnzrg3h55i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOSU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

