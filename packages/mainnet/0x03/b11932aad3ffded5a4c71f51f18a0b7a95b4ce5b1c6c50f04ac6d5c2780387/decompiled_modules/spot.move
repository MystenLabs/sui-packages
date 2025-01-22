module 0x3b11932aad3ffded5a4c71f51f18a0b7a95b4ce5b1c6c50f04ac6d5c2780387::spot {
    struct SPOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOT>(arg0, 6, b"SPOT", b"Spot Sui", b"Just a $Spot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028287_921b140337.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

