module 0xaa7ec527e12e6573d9fd83f17bb9dcea0e3dc6d14b91b50902d9c7bd016c94fb::sder {
    struct SDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDER>(arg0, 6, b"SDER", b"SUIDER", b"Hello! SUIDER Make SUI Greater", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Messenger_creation_D0_E2205_B_49_AB_4_C84_96_B7_7_C317_B6_D295_D_0299060542.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

