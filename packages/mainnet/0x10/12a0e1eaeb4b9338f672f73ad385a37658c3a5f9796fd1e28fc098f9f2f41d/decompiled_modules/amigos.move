module 0x1012a0e1eaeb4b9338f672f73ad385a37658c3a5f9796fd1e28fc098f9f2f41d::amigos {
    struct AMIGOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMIGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMIGOS>(arg0, 6, b"Amigos", b"Amigos coin", b"The meme coin on sui thats so laid-back, its practically horizontal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_Cg6e_YJO_400x400_afc7fe1fb9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMIGOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMIGOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

