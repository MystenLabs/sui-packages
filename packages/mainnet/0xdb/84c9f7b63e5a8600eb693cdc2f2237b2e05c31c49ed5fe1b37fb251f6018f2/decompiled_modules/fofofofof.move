module 0xdb84c9f7b63e5a8600eb693cdc2f2237b2e05c31c49ed5fe1b37fb251f6018f2::fofofofof {
    struct FOFOFOFOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOFOFOFOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOFOFOFOF>(arg0, 6, b"Fofofofof", b"Fofofof", b"Fkfkf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigdu3ogpuf7sou6ultyr7lpuw7kiyptkyf75apxttmmcevwgymw54")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOFOFOFOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FOFOFOFOF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

