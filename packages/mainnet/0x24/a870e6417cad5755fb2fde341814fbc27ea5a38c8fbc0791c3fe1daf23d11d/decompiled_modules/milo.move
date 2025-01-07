module 0x24a870e6417cad5755fb2fde341814fbc27ea5a38c8fbc0791c3fe1daf23d11d::milo {
    struct MILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILO>(arg0, 6, b"MILO", b"milo milo", b"Cute cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_23_at_01_48_55_1a1268cc_6c8da6c330.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILO>>(v1);
    }

    // decompiled from Move bytecode v6
}

