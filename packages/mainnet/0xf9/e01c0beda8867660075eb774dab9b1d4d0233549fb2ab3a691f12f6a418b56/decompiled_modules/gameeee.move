module 0xf9e01c0beda8867660075eb774dab9b1d4d0233549fb2ab3a691f12f6a418b56::gameeee {
    struct GAMEEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAMEEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMEEEE>(arg0, 6, b"GAMEEEE", b"IT'S TIME TO PLAY THE GAMEEE", b"IT'S TIME TO PLAY THE GAMEE-EE-EE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_23_30_46_aa06982237.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMEEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAMEEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

