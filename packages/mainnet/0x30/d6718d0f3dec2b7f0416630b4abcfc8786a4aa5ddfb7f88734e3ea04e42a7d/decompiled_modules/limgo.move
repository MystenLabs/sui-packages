module 0x30d6718d0f3dec2b7f0416630b4abcfc8786a4aa5ddfb7f88734e3ea04e42a7d::limgo {
    struct LIMGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIMGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIMGO>(arg0, 9, b"limgo", b"Limgo", b"LIMGO IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/735/487/large/gu-junyi-1903.jpg?1728441285")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LIMGO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIMGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIMGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

