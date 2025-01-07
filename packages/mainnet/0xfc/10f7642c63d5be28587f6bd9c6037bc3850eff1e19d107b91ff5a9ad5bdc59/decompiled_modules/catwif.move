module 0xfc10f7642c63d5be28587f6bd9c6037bc3850eff1e19d107b91ff5a9ad5bdc59::catwif {
    struct CATWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATWIF>(arg0, 6, b"CATWIF", b"CATWIF on SUI", b"On this Christmas, our favorite cat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vk_Tl_Ab_BC_400x400_bacd2f8bf1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

