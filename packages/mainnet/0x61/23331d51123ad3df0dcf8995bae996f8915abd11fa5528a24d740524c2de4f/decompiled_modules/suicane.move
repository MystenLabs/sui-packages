module 0x6123331d51123ad3df0dcf8995bae996f8915abd11fa5528a24d740524c2de4f::suicane {
    struct SUICANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICANE>(arg0, 6, b"SUICane", b"Suicane", b"Suicane the strongest Water Dog on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/laura_weimer_suicune_fa5f4ad1f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

