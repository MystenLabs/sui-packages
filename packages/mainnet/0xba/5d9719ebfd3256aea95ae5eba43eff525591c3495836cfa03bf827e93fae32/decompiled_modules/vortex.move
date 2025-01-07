module 0xba5d9719ebfd3256aea95ae5eba43eff525591c3495836cfa03bf827e93fae32::vortex {
    struct VORTEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VORTEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VORTEX>(arg0, 6, b"VORTEX", b"VORTEX SUI", b"Where chaos meets crypto in a delightful, blue droplet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_23_7abeec6f52.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VORTEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VORTEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

