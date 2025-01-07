module 0x708498b896c7caa642f93c82e44eaf60a58fe11eb04d6c41549b79c7f7dbf3ea::mt {
    struct MT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MT>(arg0, 6, b"MT", b"Mojak Terminal", b"mojak terminal is mogging on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf4h_Jq1g1_Zar_K3o_S2nranbg_Lx2ryi_VY_9_Zba5i6s8og_Wzk_1_8c24f24706.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MT>>(v1);
    }

    // decompiled from Move bytecode v6
}

