module 0xbc2742610ea4c318053038b0d60968d24e1bbf5eda50fb179f3cd5464f360a5d::suieet {
    struct SUIEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEET>(arg0, 6, b"Suieet", b"Suieet Token", b"The suieetest token on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia7ctuwlr6ob65wv3bcfsun3gmo7gysewodrzhwx4bjdxtrggc5ue")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIEET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

