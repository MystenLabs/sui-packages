module 0x65695d9ecc5cc548909f80673e6761e913ca90ac233b2c74621c631c313f91fb::dood {
    struct DOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOD>(arg0, 6, b"DOOD", b"Doods Sui", b"Memecoin on sui network, created by community and for the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015376_9ad2e9fa83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

