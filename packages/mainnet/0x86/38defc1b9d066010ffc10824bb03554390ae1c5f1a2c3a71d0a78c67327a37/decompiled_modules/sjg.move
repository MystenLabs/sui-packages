module 0x8638defc1b9d066010ffc10824bb03554390ae1c5f1a2c3a71d0a78c67327a37::sjg {
    struct SJG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJG>(arg0, 6, b"SJG", b"SJGSM", b"S.J.G.S.M.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S_J_G_S_M_b6de76fb3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SJG>>(v1);
    }

    // decompiled from Move bytecode v6
}

