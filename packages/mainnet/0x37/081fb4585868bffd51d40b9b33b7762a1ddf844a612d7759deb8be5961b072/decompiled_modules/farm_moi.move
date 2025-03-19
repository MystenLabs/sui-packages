module 0x37081fb4585868bffd51d40b9b33b7762a1ddf844a612d7759deb8be5961b072::farm_moi {
    struct FARM_MOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARM_MOI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742356085247.png"));
        let (v1, v2) = 0x2::coin::create_currency<FARM_MOI>(arg0, 6, b"FARM_MOI", b"FARM_MOI", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARM_MOI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARM_MOI>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<FARM_MOI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FARM_MOI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

