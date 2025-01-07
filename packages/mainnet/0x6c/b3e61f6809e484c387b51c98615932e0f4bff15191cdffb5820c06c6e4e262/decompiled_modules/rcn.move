module 0x6cb3e61f6809e484c387b51c98615932e0f4bff15191cdffb5820c06c6e4e262::rcn {
    struct RCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCN>(arg0, 6, b"RCN", b"Racoon", b"Racoon Token is a unique cryptocurrency designed to support raccoon conservation efforts and raise awareness about the importance of protecting these intelligent animals. Each transaction with Racoon Token contributes a portion to wildlife foundations and initiatives focused on preserving raccoon habitats and ensuring their well-being. The token aims to build a community of animal lovers who actively participate in environmental sustainability while also benefiting from the growing world of decentralized finance (DeFi). Through blockchain technology, Racoon Token offers transparency, security, and a fun way to contribute to a worthy cause.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_7b3417c625.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

