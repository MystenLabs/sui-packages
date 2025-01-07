module 0xd65d2068ae56069b8e7961e149b5d21b990696437bef5dc797290043c1bb3043::feng {
    struct FENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENG>(arg0, 6, b"FENG", b"Feng Sui", b"$FENG brings balance and luck for your $SUI wallet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000263_773de3110f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

