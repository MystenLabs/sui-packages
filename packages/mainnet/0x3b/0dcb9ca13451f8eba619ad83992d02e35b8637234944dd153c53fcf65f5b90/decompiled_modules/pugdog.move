module 0x3b0dcb9ca13451f8eba619ad83992d02e35b8637234944dd153c53fcf65f5b90::pugdog {
    struct PUGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGDOG>(arg0, 6, b"PUGDOG", b"Puggydogsui", b"Puggy dog is a memecoins big in the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000084553_b61d6fcc8d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

