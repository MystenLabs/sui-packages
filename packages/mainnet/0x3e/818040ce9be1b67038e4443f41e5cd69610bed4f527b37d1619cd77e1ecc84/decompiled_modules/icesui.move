module 0x3e818040ce9be1b67038e4443f41e5cd69610bed4f527b37d1619cd77e1ecc84::icesui {
    struct ICESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICESUI>(arg0, 6, b"IceSui", b"ICE", b"Ice Sui Dao", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ice_cube_baby_fantasy_cartoon_character_cute_9c8ffe5a06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

