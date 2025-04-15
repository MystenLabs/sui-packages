module 0x9233da7c27744e2cb54bcdb37c5065bffa855eec0baf63a051b6cb7acf53d183::barak {
    struct BARAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARAK>(arg0, 6, b"BARAK", b"Moonbarak", x"5468652052696368657374204b696e67206f6e205355492c20726561647920746f206d6f6f6e2066726f6d20447562616920746f207468652073746172732120f09f9a80f09f8c99f09f8c95", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreicsaiyfasopsxdiyu7dtmvjdxle6amr3ascbygkjhtixnm66c6uki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BARAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

