module 0x3d97a75cae8a8d7366aed16cde74a11522e8e4552f45ff221b30d41c21c0d288::dull {
    struct DULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DULL>(arg0, 6, b"Dull", b"Hopdull", b"Fun??Dull!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1283_BC_4_C_5100_4447_9_B10_13_F6_F8_A55_A57_aa3bbd8ff3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

