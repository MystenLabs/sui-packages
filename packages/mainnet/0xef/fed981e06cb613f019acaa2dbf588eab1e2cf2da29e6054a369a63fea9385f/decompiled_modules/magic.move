module 0xeffed981e06cb613f019acaa2dbf588eab1e2cf2da29e6054a369a63fea9385f::magic {
    struct MAGIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGIC>(arg0, 6, b"Magic", b"Wizard Land", b"Expanding the Magic Land", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RWCSQ_9_Q0_400x400_78691ae084.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

