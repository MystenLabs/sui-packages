module 0x4cb860a18f358e79b544e411660511573175f06609b41a1ac98881ea36de25f4::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"Make America Great Again", b"Make America Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.pbs.org/newshour/app/uploads/2016/07/RTX2I5VR-1024x683.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGA>(&mut v2, 690000001000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

