module 0xf1515dd01cf31174318eb552bc7ca792972bddf90b8700443b13d62e938f02fc::brosui {
    struct BROSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROSUI>(arg0, 6, b"BROSUI", b"BROCCOLI ON SUI", x"42524f43434f4c4920435a20444f47204f4e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_Z_Wp_NBX_8_400x400_46411c8021.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

