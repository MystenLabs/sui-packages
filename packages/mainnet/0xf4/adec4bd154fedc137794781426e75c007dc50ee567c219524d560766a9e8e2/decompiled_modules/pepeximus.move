module 0xf4adec4bd154fedc137794781426e75c007dc50ee567c219524d560766a9e8e2::pepeximus {
    struct PEPEXIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEXIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEXIMUS>(arg0, 6, b"PEPEXIMUS", b"Pepeximus", b"Pepeximus  fueled by pure memetic nitro. So Pepeximus will win the race of Big MEMEs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BY_Ki_U5n_D_400x400_f5822b4031.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEXIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEXIMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

