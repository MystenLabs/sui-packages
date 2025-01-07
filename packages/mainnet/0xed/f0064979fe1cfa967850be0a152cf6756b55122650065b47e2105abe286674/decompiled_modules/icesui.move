module 0xedf0064979fe1cfa967850be0a152cf6756b55122650065b47e2105abe286674::icesui {
    struct ICESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICESUI>(arg0, 6, b"ICESUI", b"ICE", x"496365205375692044616f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ice_cube_baby_fantasy_cartoon_character_cute_9c8ffe5a06_557c6436d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

