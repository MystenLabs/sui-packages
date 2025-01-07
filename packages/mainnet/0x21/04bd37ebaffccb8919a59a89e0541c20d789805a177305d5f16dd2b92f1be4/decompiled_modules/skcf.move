module 0x2104bd37ebaffccb8919a59a89e0541c20d789805a177305d5f16dd2b92f1be4::skcf {
    struct SKCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKCF>(arg0, 6, b"SKCF", b"smokingchickenfish", b"The combination of chicken and fish and tobacco", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/scf_caa7843a1b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

