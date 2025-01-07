module 0x44e790daef93c800327b651a3a92e4af56bd4981ccc10311ef457879e26bc77d::slave {
    struct SLAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAVE>(arg0, 6, b"SLAVE", b"SLAVE PEPE", b" $SLAVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l2u_RT_4o0_400x400_28d445900d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

