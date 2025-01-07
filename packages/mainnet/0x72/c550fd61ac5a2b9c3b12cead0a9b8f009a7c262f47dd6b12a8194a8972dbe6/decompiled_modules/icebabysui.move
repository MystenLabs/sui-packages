module 0x72c550fd61ac5a2b9c3b12cead0a9b8f009a7c262f47dd6b12a8194a8972dbe6::icebabysui {
    struct ICEBABYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICEBABYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICEBABYSUI>(arg0, 6, b"ICEbabySui", b"ICEbaby", b"ICEbaby Coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ice_cube_baby_fantasy_cartoon_character_cute_71e72a76ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICEBABYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICEBABYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

