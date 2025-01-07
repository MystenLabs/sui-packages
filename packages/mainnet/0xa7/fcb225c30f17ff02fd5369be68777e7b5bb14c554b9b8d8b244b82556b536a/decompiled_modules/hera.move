module 0xa7fcb225c30f17ff02fd5369be68777e7b5bb14c554b9b8d8b244b82556b536a::hera {
    struct HERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERA>(arg0, 6, b"HERA", b"HERA on sui", b"@HerasAdventure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_C2o_Gb_Qm_400x400_173980f138.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HERA>>(v1);
    }

    // decompiled from Move bytecode v6
}

