module 0x8204cac2ab21873455c2ab6ab505d7710b07bd86e36c33da34dc0f7de5599247::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHI>(arg0, 6, b"Satoshi", b"Satoshi Sui", b"Sui is the blockchain Satoshi always wanted Bitcoin to be. Let us follow his lead and grow this new community. He needs to rebuild now that he has been reborn. Let us help in building the future of blockchain on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Satoshi_fa07bce8bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

