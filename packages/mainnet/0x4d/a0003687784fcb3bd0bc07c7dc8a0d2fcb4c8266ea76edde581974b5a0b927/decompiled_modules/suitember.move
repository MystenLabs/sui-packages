module 0x4da0003687784fcb3bd0bc07c7dc8a0d2fcb4c8266ea76edde581974b5a0b927::suitember {
    struct SUITEMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEMBER>(arg0, 6, b"Suitember", b"Sui", b"You ready for #SuiTember phase 2? #Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_e50d4a7e5f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

