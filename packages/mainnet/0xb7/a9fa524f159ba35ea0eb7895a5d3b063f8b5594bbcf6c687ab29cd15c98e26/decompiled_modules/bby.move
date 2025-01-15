module 0xb7a9fa524f159ba35ea0eb7895a5d3b063f8b5594bbcf6c687ab29cd15c98e26::bby {
    struct BBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBY>(arg0, 6, b"BBY", b"Baby Pengu on Sui", b"The official launch of Baby Pengu on Sui. Join the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profile_be36d4a9b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

