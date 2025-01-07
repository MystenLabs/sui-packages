module 0xdf1907b80324196a51556906a1ff3cc35d844c1f7b74ef3c2c3dc66c22e2987a::skechers {
    struct SKECHERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKECHERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKECHERS>(arg0, 6, b"SKECHERS", b"SKETCHERS", b"I LIKE YOUR SKECHERS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_67_138d14d2be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKECHERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKECHERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

