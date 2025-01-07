module 0x35a26828989dcca38888023359108329353b4d530666d18c769c78f46bbb7d32::zona {
    struct ZONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZONA>(arg0, 6, b"ZONA", b"Zona Zurvival", b"Part of the ZONA project supporting the $ZONA coin, places players in classic Russian prison situations. Make critical decisions, build your reputation, and increase your influence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mg_G_Bov2_SBX_79c_Ze_C9_Immaoh_Dlo_ac992a670a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

