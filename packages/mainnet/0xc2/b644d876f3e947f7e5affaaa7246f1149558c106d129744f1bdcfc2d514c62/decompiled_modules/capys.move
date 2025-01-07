module 0xc2b644d876f3e947f7e5affaaa7246f1149558c106d129744f1bdcfc2d514c62::capys {
    struct CAPYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYS>(arg0, 6, b"CAPYS", b"Suifrens: Capys", b"Make Suifrens great again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/capy_about_beb55b1d24.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

