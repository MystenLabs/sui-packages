module 0xe0536ae102556490b167288c1e5be9eb7ba745a464301f55f50bb2785205e1::nakula {
    struct NAKULA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKULA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKULA>(arg0, 6, b"NAKULA", b"Nakula on SUI", b"Long nose monkey on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_Fr3d_Xv_Q_400x400_e2d37fa5f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKULA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAKULA>>(v1);
    }

    // decompiled from Move bytecode v6
}

