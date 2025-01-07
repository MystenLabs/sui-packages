module 0x65a4010369f623541e67f05d0591aa2df104ddde5fadf306b66754db7106db2::tb2 {
    struct TB2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TB2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TB2>(arg0, 6, b"TB2", b"Thunderbird2", b"Thunderbird two of four | Get 'm all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TB_2_39c2470bca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TB2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TB2>>(v1);
    }

    // decompiled from Move bytecode v6
}

