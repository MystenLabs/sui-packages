module 0xf1c5344d8cd2d561a763499d912f0b6e3d9a9bd1d1974f37a0eba660365c2926::bubble {
    struct BUBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLE>(arg0, 6, b"BUBBLE", b"Bubble On Sui", b"Its me, Bubble! Floating through the skies of Sui,bringing joy and looking out for every traveller. There are places youve never imagined waiting to be discovered,and theres always something exciting just ahead.Lets see where were off to next.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b5a74494_068c_4425_895d_59d5ac75d11d_8314a0c8b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

