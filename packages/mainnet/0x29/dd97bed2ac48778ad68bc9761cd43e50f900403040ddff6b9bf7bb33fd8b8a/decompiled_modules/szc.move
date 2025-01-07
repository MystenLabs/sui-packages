module 0x29dd97bed2ac48778ad68bc9761cd43e50f900403040ddff6b9bf7bb33fd8b8a::szc {
    struct SZC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZC>(arg0, 6, b"SZC", b"Suizcanal", b"Suizcanal on \"SUI\" shall outpace annual trade of 10bil USD from Suez Canal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030357_bff22d095d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SZC>>(v1);
    }

    // decompiled from Move bytecode v6
}

