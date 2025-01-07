module 0xec5002b2bae412262e739a20d292beaf8394d97ac170652f613006cab0dcece1::fluffi {
    struct FLUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFI>(arg0, 6, b"FLUFFI", b"FLUFFI on SUI", x"496e66696e697465206d656d65732c20496e66696e6974652066756e2020506f7765726564206279200a67726f6b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9tao8i_m_400x400_7bf6ee3bad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

