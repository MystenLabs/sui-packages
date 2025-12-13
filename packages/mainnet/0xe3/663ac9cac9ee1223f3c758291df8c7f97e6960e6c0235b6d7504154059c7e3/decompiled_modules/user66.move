module 0xe3663ac9cac9ee1223f3c758291df8c7f97e6960e6c0235b6d7504154059c7e3::user66 {
    struct USER66 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USER66, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USER66>(arg0, 6, b"User66", b"Duncandd", b"my test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/10f7733f_0556_4af9_b152_41baacca67f3_3a6b9d7a32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USER66>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USER66>>(v1);
    }

    // decompiled from Move bytecode v6
}

