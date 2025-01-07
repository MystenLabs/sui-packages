module 0x4ea2656584bc91b8cc1add7596f6d7e817063f74fb624bfafb39aeb2e571be2d::suicrab {
    struct SUICRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICRAB>(arg0, 6, b"SUICRAB", b"Sui Crab", x"5375692043726162277320676f7420636c6177732c20616e642069742773206e6f742061667261696420746f20757365207468656d2e20437261776c696e67206f7574206f6620746865206465657020776174657273206f66205375692c20746869732063726162206973206865726520746f2070696e6368206974732077617920746f2074686520746f70206f66205375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_58_ee318be098.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICRAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

