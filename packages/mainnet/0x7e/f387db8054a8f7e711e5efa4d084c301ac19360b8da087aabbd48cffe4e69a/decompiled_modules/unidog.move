module 0x7ef387db8054a8f7e711e5efa4d084c301ac19360b8da087aabbd48cffe4e69a::unidog {
    struct UNIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIDOG>(arg0, 6, b"UniDOG", b"Uni DOG", x"556e69202d204e616d65642061667465722053756920636f2d666f756e646572204576616e204368656e67277320646f672e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/192e912e99aw0da_6f7e70517a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

