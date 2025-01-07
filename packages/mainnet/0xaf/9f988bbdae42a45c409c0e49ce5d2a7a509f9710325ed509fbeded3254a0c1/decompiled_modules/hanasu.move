module 0xaf9f988bbdae42a45c409c0e49ce5d2a7a509f9710325ed509fbeded3254a0c1::hanasu {
    struct HANASU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANASU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANASU>(arg0, 6, b"HANASU", b"HANA SUI", b"So, if you're ready to join the revolution, strap in and get ready for an adventure like no other. Hanasui is here to redefine what it means to be a cryptocurrency project. Are you up for the challenge? Let's dive into the Hanasui together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b17de8df_5b9d_413c_bc57_8bef350cb6e8_1562261d6a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANASU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANASU>>(v1);
    }

    // decompiled from Move bytecode v6
}

