module 0x5119476073bcd07009e6fdbda889d20c703b3382fbd035b5895aba0e5749f3f4::orgo {
    struct ORGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORGO>(arg0, 6, b"ORGO", b"ORGO SUI", b"Dive into crypto riches with Ocean Gorilla! $ORGO token, the treasure-keeping king of the ocean's depths, yields aquatic abundance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_SE_Kr_Hg_W_400x400_9aabe935e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

