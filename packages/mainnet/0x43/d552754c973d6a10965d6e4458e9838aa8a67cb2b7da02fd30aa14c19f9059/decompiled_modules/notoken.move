module 0x43d552754c973d6a10965d6e4458e9838aa8a67cb2b7da02fd30aa14c19f9059::notoken {
    struct NOTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTOKEN>(arg0, 6, b"NoToken", b"NO TOKEN", b"There is no token!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_18eaa31b42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

