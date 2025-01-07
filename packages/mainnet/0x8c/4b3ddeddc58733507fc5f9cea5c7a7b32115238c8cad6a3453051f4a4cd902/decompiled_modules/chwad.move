module 0x8c4b3ddeddc58733507fc5f9cea5c7a7b32115238c8cad6a3453051f4a4cd902::chwad {
    struct CHWAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHWAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHWAD>(arg0, 6, b"CHWAD", b"Sui Chwad", b"The only CHWAD on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mpjlv8_Rc_400x400_fb6bb413b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHWAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHWAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

