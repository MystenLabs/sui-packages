module 0x2d5008c7804d5af1973447274d5bba05474018249f03488867d022ddd71c62a3::ddog {
    struct DDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDOG>(arg0, 6, b"DDOG", b"Dev Dog", b"Home to all Dogs and Devs on Sui. Links are now live!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/my_dog_d68dc86209.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

