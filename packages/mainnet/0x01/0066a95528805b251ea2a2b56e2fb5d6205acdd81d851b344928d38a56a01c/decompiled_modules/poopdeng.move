module 0x10066a95528805b251ea2a2b56e2fb5d6205acdd81d851b344928d38a56a01c::poopdeng {
    struct POOPDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOPDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOPDENG>(arg0, 6, b"POOPDENG", b"POPDENG", b"POPCAT + MOONDENG = POPDENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7fq_I_Ugz_A_400x400_42ed943627.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOPDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOPDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

