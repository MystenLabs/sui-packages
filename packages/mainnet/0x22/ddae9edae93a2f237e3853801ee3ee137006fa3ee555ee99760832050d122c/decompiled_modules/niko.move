module 0x22ddae9edae93a2f237e3853801ee3ee137006fa3ee555ee99760832050d122c::niko {
    struct NIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKO>(arg0, 6, b"NIKO", b"NIKO on SUI", b"NIKO, the cutest and most famous Japanese baby seal on the internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_F_Iwp_P_D_400x400_1_7c94b6309f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

