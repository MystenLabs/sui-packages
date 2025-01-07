module 0x6ad3d5acc1aa9345ef455551081e4b30497ae5e52308a79ec0f6ae0c3ba106e1::loco {
    struct LOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCO>(arg0, 6, b"LOCO", b"LO & CO", b"LocoWifCoco", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dfc_ax_Ch_400x400_72d39ff7de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

