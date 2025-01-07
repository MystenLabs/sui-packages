module 0xd71a3d0839f454ddc078fd1d992517757886335ec28beb06be73420623536eb7::babykisa {
    struct BABYKISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYKISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYKISA>(arg0, 9, b"babykisa", b"Baby Kisa", b"Meow Baby Kisa Sui Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1840740934020968448/AfpnAGNM_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYKISA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYKISA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYKISA>>(v1);
    }

    // decompiled from Move bytecode v6
}

