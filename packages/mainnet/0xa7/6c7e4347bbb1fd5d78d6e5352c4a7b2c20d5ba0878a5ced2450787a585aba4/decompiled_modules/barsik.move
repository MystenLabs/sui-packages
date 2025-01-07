module 0xa76c7e4347bbb1fd5d78d6e5352c4a7b2c20d5ba0878a5ced2450787a585aba4::barsik {
    struct BARSIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARSIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARSIK>(arg0, 6, b"BARSIK", b"Vitalik's Mom Cat", x"0a0a42415253494b20697320746865206e616d65206f662074686520636174206f66206f75722062656c6f76656420204e6174616c696120416d656c696e6528566974616c696b73204d6f6d290a436f6d6520616e64206a6f696e20746f207769746e65737320746865207269736520696e2042617273696b2061732068652074616b657320746865207468726f6e65206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9d_Q0_Zi8r_400x400_057d6a748f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARSIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARSIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

