module 0xabc5fc1a5079df3d2486a74bdefc580ce027f6cd8aa61185083e15c1bb0b01e5::dug {
    struct DUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUG>(arg0, 6, b"DUG", b"DUG INU", x"496e73706972696e67206f746865727320746f207072696f726974697a6520736563757269747920616e6420696e6e6f766174696f6e207768696c6520616464696e67206120746f756368206f662066756e20616e64207768696d737920746f207468652063727970746f2073706163652e2054616b6520616476616e74616765206f6620746865206669727374206d61726b6574206d6f76657273207769746820535549206d656d65636f696e73210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_67_4ce57c8d39.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

