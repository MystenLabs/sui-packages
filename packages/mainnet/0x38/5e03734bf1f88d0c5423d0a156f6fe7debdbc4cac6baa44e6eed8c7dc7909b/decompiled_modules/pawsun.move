module 0x385e03734bf1f88d0c5423d0a156f6fe7debdbc4cac6baa44e6eed8c7dc7909b::pawsun {
    struct PAWSUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWSUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWSUN>(arg0, 6, b"PAWSUN", b"PawsunOnSui", x"54686520707572722d6665637420626c656e64206f6620636861726d20616e642063727970746f200a2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250429_233741_448_8a15997039.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWSUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAWSUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

