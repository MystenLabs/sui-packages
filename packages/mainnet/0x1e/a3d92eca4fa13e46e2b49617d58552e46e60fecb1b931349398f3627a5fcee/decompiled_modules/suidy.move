module 0x1ea3d92eca4fa13e46e2b49617d58552e46e60fecb1b931349398f3627a5fcee::suidy {
    struct SUIDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDY>(arg0, 6, b"SUIDY", b"Suidermen", b"Suidermen, known as Spodermen or Spooderman, is an MS Paint character resembling a poorly-drawn version of Spiderman. The character usually appears as a recurring character in Dolan comics or videos. Any content involving Spoderman typically contains poor grammar and spelling, and has many signature phrases such as \"an fagit\", and \"sweg\".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_Movepump_b7eba5c4fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

