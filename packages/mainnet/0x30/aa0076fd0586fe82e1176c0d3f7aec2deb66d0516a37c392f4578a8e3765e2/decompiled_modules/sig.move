module 0x30aa0076fd0586fe82e1176c0d3f7aec2deb66d0516a37c392f4578a8e3765e2::sig {
    struct SIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIG>(arg0, 6, b"SIG", b"SIGSI", x"4d6565742050696773692c207468652063727970746f207069676c65742077686f7320616c77617973206168656164206f660a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/89_Y_Cb_Bxj_400x400_425f69da19.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

