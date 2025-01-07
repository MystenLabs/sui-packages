module 0x37d1cb4f962ff3e871ee9a8d02b08d953061be5370919fab0dd7eee67d76666a::niko {
    struct NIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKO>(arg0, 6, b"NIKO", b"NIKO on SUI", b"NIKO, the cutest and most famous Japanese baby seal on the internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_F_Iwp_P_D_400x400_be0761c78c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

