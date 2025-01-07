module 0xab4dea9a2a89d96e3e19428c4ae83dcd2686b86682ba9afae3cd81dc6b4e7e2f::updog {
    struct UPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPDOG>(arg0, 6, b"UPDOG", b"Onlyupdog", b"Only up dog on eth ready for uptober", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_16_59_40_563317a5dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

