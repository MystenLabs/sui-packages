module 0xb62ec244496de710f7d901dbc4979f61c867e410fc6d7b5f95c35d24d3955055::shamu {
    struct SHAMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAMU>(arg0, 6, b"SHAMU", b"SHAMU THE WHALE", b"$Shamu is the ultimate memecoin for the biggest whales in the crypto world, paying homage to the most famous whale of all time: Shamu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3810_2ba2dabe07.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

