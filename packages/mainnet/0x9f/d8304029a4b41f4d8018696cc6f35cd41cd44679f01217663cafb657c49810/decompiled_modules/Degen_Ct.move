module 0x9fd8304029a4b41f4d8018696cc6f35cd41cd44679f01217663cafb657c49810::Degen_Ct {
    struct DEGEN_CT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGEN_CT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN_CT>(arg0, 9, b"KIRA", b"Degen Ct", b"just posting shit. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1636443983990669326/xm-YehdR_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGEN_CT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN_CT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

