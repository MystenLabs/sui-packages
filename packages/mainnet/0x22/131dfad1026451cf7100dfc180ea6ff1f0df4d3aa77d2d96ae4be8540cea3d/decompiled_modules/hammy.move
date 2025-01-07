module 0x22131dfad1026451cf7100dfc180ea6ff1f0df4d3aa77d2d96ae4be8540cea3d::hammy {
    struct HAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMMY>(arg0, 6, b"HAMMY", b"HAMMY on SUI", b"Everyone Loves $Hammy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BN_we_Ajq_400x400_ad7a2ace06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

