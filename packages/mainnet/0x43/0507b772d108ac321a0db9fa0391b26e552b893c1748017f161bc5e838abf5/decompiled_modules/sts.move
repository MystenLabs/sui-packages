module 0x430507b772d108ac321a0db9fa0391b26e552b893c1748017f161bc5e838abf5::sts {
    struct STS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STS>(arg0, 6, b"STS", b"Suimmertime Saga", b"Suimmertime Saga Coin is a bold and edgy meme token inspired by the chaos of summer misadventures. Built for the daring, it thrives on humor, rebellion, and a sense of no-holds-barred fun in the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/161032173277171_Y3_Jvc_Cwx_Mj_U1_L_Dk4_M_Sww_LDE_0_OQ_fc0f611462.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STS>>(v1);
    }

    // decompiled from Move bytecode v6
}

