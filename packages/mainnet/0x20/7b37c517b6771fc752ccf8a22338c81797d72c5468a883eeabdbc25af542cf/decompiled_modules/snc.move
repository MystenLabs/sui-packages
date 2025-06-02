module 0x207b37c517b6771fc752ccf8a22338c81797d72c5468a883eeabdbc25af542cf::snc {
    struct SNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNC>(arg0, 6, b"SNC", b"Suinic", b"Pixel speed, chain pumps hold your coins, Suinic's blazing to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibggg322azcwgqnwo7vwd62uux4mce54ihveqjnvp7glfm7546tt4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

