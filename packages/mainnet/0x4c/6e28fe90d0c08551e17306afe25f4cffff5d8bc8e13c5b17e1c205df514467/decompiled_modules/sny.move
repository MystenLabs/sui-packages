module 0x4c6e28fe90d0c08551e17306afe25f4cffff5d8bc8e13c5b17e1c205df514467::sny {
    struct SNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNY>(arg0, 6, b"SNY", b"SANIY", b"Memecoin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_r_Ikmav_Ueqy_Ry_Swl_Qd_A9k_Kg_cefd59dfa2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

