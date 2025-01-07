module 0xec3b419c718c7f4865d406008a1f482450cc937245282fe09aca20452b82c01f::suibpopshark {
    struct SUIBPOPSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBPOPSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBPOPSHARK>(arg0, 6, b"SUIBPOPSHARK", b"BABY POP SHARK", b"Baby pop shark sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3496_a5d118fc42.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBPOPSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBPOPSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

