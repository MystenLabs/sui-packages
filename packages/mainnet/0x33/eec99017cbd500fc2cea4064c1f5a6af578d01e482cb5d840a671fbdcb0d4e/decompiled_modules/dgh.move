module 0x33eec99017cbd500fc2cea4064c1f5a6af578d01e482cb5d840a671fbdcb0d4e::dgh {
    struct DGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGH>(arg0, 6, b"Dgh", b"sdf", b"cdfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aafb228def8cc26f43aa59c807f5206b_5768bc9f6c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

