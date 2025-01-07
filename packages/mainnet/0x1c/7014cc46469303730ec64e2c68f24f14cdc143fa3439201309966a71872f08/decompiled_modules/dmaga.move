module 0x1c7014cc46469303730ec64e2c68f24f14cdc143fa3439201309966a71872f08::dmaga {
    struct DMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMAGA>(arg0, 6, b"DMAGA", b"Dark Maga", x"4d616b6520416d657269636120477265617420416761696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DMAGA_TPS_Jaq_Z5e1uuex_OL_Jm_57ca1528d2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

