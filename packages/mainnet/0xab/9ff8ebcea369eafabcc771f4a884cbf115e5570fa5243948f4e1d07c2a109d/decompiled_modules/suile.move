module 0xab9ff8ebcea369eafabcc771f4a884cbf115e5570fa5243948f4e1d07c2a109d::suile {
    struct SUILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILE>(arg0, 6, b"SUILE", b"suileman", b"Suileman - Sui's Unofficial Peace Mascot Move over...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gd_SI_2_Ks_Wo_AA_1_E_Oq_9b123a05be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

