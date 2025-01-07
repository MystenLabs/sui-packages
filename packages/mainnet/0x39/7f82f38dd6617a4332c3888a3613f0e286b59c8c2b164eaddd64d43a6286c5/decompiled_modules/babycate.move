module 0x397f82f38dd6617a4332c3888a3613f0e286b59c8c2b164eaddd64d43a6286c5::babycate {
    struct BABYCATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYCATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYCATE>(arg0, 6, b"BABYCATE", b"BabyCate", x"4c65742773204d616b652042534320477265617420416761696e210a0a546865204d656d65636f696e206d61726b6574206f6e2042534320686173206265656e2071756965742073696e636520746865206b696e672077617320696d707269736f6e65642e204c65742773206d616b6520746865204d656d65636f696e206d61726b6574206f6e2042534320477265617420416761696e207769746820426162794361746521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/baby_cate_1da94e77b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYCATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYCATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

