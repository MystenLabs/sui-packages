module 0xba9c666d58ecebb2cc98e34d1b015aa6236e9f28b4f384ebb40f7b3b3b3f56c4::swmg {
    struct SWMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWMG>(arg0, 6, b"SWMG", b"Shadow wizard money gang", b"Shadow Wizard Money Gang ($GANG) is like the wild child of the crypto world, born from the mad genius of DJ Smokey's \"We Love Casting Spells\" producer tag. Just like that time Joeyy dropped the \"Legalize Nuclear Bombs\" tag and blew up the music scene, $GANG is here to make crypto history in the craziest way possible.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_17_09_44_e5a7def2e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

