module 0x925832cb03d614c9aa0732c20665a88fa74f8ad9fa574f4ed51cd64af5818f8f::snomas {
    struct SNOMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOMAS>(arg0, 6, b"SNOMAS", b"Snowy on Sui", x"496d20536e6f777920546865204368726973746d617320446f672078440a24534e4f4d4153", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/enhanced_hd_image_6e7021894d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

