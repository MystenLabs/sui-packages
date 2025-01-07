module 0x78446bf3be24cc138c33b15218d887716026177e15bdb451068b90af086eea7e::fractalpepe {
    struct FRACTALPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRACTALPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRACTALPEPE>(arg0, 6, b"FractalPEPE", b"Fractalpepes", b"Are you one of us?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_Ns_AAX_Mj_400x400_dd0794550f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRACTALPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRACTALPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

