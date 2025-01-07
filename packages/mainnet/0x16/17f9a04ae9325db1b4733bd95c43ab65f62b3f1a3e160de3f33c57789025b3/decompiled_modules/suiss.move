module 0x1617f9a04ae9325db1b4733bd95c43ab65f62b3f1a3e160de3f33c57789025b3::suiss {
    struct SUISS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISS>(arg0, 6, b"Suiss", b"Suisstzerland the dog", b"The official dog of Suisstzerland", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_3_92f9508339.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISS>>(v1);
    }

    // decompiled from Move bytecode v6
}

