module 0xce9c718abbe2a31c06ba1efe1fcaec5724afa02ef9f64e31c135b03027db6c4d::catfood {
    struct CATFOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFOOD>(arg0, 6, b"Catfood", b"Sui brand cat food", b"If you come for the king, you better not miss.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240925141546_15c2706872.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATFOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

