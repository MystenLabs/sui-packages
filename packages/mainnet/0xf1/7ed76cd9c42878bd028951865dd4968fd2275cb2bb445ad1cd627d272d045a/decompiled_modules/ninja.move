module 0xf17ed76cd9c42878bd028951865dd4968fd2275cb2bb445ad1cd627d272d045a::ninja {
    struct NINJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINJA>(arg0, 6, b"NiNJA", b"BATMANNinja", b"Batman Ninja redefines the Dark Knight, merging his unyielding resolve with the honor and chaos of feudal Japana hero reborn in the shadow of samurai and shinobi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033702_ea34950c94.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

