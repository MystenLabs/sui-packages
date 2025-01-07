module 0x4406a86506a4c88e098ef1f9886c320f993f3eb566a9f66065024d7b1246b07d::stacy {
    struct STACY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STACY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STACY>(arg0, 6, b"STACY", b"Stacy Sui", b"Stacy Tribute on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_Tz_L_Cnyn_400x400_3a00a70b6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STACY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STACY>>(v1);
    }

    // decompiled from Move bytecode v6
}

