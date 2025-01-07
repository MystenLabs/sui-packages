module 0x369130733a6926236987c4030c0bb3140f376bca2068ca2fcdca876fc173b8fc::suigga {
    struct SUIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGGA>(arg0, 6, b"SUIGGA", b"Suiga Sui", b"Coldest Suigga Breathing On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_113307_8f1371b597.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

