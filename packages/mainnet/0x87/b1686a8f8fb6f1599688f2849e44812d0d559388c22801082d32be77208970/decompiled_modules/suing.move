module 0x87b1686a8f8fb6f1599688f2849e44812d0d559388c22801082d32be77208970::suing {
    struct SUING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUING>(arg0, 6, b"SUING", b"SUI SUING", b"Buy 5 SUI worth of $SUING to get whitelisted for the NFT collection.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suing_14beee5a02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUING>>(v1);
    }

    // decompiled from Move bytecode v6
}

