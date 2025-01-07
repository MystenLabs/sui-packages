module 0x34199ee909f8c60df48b25aeb93da3ce5fa99f535c1978a8eb40867032dff7eb::giga {
    struct GIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGA>(arg0, 6, b"GiGA", b"Giga on Sui", x"0a54686520317374202447494741206465706c6f796564206f6e205375692c20636f6d6d756e6974792d6d616e616765642e0a5468652068656972206170706172656e7420746f20444f47452e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_O_O_U_U_O_U_2_ac888471ed.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

