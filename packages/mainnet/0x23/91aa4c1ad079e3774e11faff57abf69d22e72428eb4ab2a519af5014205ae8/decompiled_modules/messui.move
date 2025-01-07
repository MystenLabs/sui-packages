module 0x2391aa4c1ad079e3774e11faff57abf69d22e72428eb4ab2a519af5014205ae8::messui {
    struct MESSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSUI>(arg0, 6, b"MESSUI", b"Messi on Sui", b"This is Messi  The number one football player in the world, now we are on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Whats_App_Image_2024_09_24_at_8_14_41_PM_574300d3fb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

