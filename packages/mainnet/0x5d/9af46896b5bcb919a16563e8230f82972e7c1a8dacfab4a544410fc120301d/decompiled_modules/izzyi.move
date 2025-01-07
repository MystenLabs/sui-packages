module 0x5d9af46896b5bcb919a16563e8230f82972e7c1a8dacfab4a544410fc120301d::izzyi {
    struct IZZYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZZYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IZZYI>(arg0, 6, b"IZZYI", b"IZZYSUI", b"$IZZYSUI, the Golden Retriever of Matt Furie, creator of Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hs_Q_Qi_Y_Fx_400x400_copy_2bed27c9f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZZYI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IZZYI>>(v1);
    }

    // decompiled from Move bytecode v6
}

