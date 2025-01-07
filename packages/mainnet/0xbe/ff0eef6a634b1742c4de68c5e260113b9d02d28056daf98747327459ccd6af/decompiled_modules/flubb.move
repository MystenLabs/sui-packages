module 0xbeff0eef6a634b1742c4de68c5e260113b9d02d28056daf98747327459ccd6af::flubb {
    struct FLUBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUBB>(arg0, 6, b"Flubb", b"Combine", b"Stake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6150918aa41f5f65bd2d7c6ac02d02d2_2cb4e6be46.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

