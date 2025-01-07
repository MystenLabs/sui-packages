module 0x74eb7f79a1d92dbcd8b046441e1b6b152ba7def205be06af0a5b603ef8840fac::ksg {
    struct KSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSG>(arg0, 6, b"KSG", b"KING SUGAR GLIDER", b"King Sugar Glider sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_H_Napl_Sz_400x400_cb894799b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

