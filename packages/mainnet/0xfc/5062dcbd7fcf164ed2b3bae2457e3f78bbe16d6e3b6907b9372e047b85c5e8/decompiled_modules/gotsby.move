module 0xfc5062dcbd7fcf164ed2b3bae2457e3f78bbe16d6e3b6907b9372e047b85c5e8::gotsby {
    struct GOTSBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOTSBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOTSBY>(arg0, 6, b"GOTSBY", b"Gotsby Guy", b"JUST A GOTSBY GUY - Our goal is to make gotsby guy a real and long - Lasting meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021048_0753b1a556.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOTSBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOTSBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

