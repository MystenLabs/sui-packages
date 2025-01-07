module 0x43b034ef4e43c236a62a1da4da1e516722691e5f28c702bf0a6c7590f79eb35c::castle {
    struct CASTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASTLE>(arg0, 6, b"CASTLE", b"Sand Castle of Sui", b"Built for the beach, living on the blockchain. Sand Castle of Sui holds the fort in the Sui dunes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ag_fe64e25995.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

