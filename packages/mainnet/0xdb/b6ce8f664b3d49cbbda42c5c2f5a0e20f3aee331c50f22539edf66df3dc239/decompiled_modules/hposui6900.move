module 0xdbb6ce8f664b3d49cbbda42c5c2f5a0e20f3aee331c50f22539edf66df3dc239::hposui6900 {
    struct HPOSUI6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPOSUI6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPOSUI6900>(arg0, 6, b"HPOSUI6900", b"BITCOIN6900", b"THE HARRY POTTER OBAMA SONIc 6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3522_df6416c125.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPOSUI6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HPOSUI6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

