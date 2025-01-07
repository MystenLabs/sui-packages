module 0x5fe4002be9a3d65ea56eb2c33d5f8f07c705596e0c4256056d06091c494e6261::sdg {
    struct SDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDG>(arg0, 6, b"SDG", b"SUI DENG", b"SUI MOO DENG TIME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_8d85bfbca7.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

