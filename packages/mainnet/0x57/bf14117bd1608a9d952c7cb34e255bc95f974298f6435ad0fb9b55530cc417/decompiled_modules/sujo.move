module 0x57bf14117bd1608a9d952c7cb34e255bc95f974298f6435ad0fb9b55530cc417::sujo {
    struct SUJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUJO>(arg0, 6, b"Sujo", b"Sui jojo", b"The cutest dog on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUJO_5_6ddf61e6ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

