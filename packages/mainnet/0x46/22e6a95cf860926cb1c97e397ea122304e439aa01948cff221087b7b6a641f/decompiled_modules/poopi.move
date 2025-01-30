module 0x4622e6a95cf860926cb1c97e397ea122304e439aa01948cff221087b7b6a641f::poopi {
    struct POOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOPI>(arg0, 6, b"PoopI", b"PoopIsland", b"Turn your dreams into Shit on PoopIsland. Launchpad live in 5 days. No socials just trust our devs Justin and Scott from Guadalajara, Mexico.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_6_1c16b9a707.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

