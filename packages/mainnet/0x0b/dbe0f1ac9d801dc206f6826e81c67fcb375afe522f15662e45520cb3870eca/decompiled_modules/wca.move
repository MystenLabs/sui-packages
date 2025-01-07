module 0xbdbe0f1ac9d801dc206f6826e81c67fcb375afe522f15662e45520cb3870eca::wca {
    struct WCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCA>(arg0, 6, b"Wca", b"Wetcat", b"Wecat changing the world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9943_B99_B_E871_4483_9_C8_D_92_C35_BC_5463_F_f65d67f72b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

