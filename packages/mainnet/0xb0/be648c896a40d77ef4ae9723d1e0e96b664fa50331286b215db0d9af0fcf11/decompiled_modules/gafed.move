module 0xb0be648c896a40d77ef4ae9723d1e0e96b664fa50331286b215db0d9af0fcf11::gafed {
    struct GAFED has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAFED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAFED>(arg0, 6, b"GaFed", b"GarField", b"Cats GarField cutes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_fotor_bg_remover_2024092191053_bba24720bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAFED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAFED>>(v1);
    }

    // decompiled from Move bytecode v6
}

