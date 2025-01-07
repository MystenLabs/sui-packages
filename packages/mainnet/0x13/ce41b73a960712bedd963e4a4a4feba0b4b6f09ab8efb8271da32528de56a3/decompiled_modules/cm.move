module 0x13ce41b73a960712bedd963e4a4a4feba0b4b6f09ab8efb8271da32528de56a3::cm {
    struct CM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CM>(arg0, 6, b"CM", b"Catseus Maximus", b"CM ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Jovhfh6_G8o_LM_9k8er_Aurjq_YBMUWUS_Qy_Uizad_B1d_Vm_DV_1994169e42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CM>>(v1);
    }

    // decompiled from Move bytecode v6
}

