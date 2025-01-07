module 0x6945dd7e73e23c22f42cf3e62e7473c1fd2915a561ffd3ff720c91014b994b89::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"Scat", b"Sprite Cat On Sui", b"Dive into the pixelated world of SpriteCat, the ultimate crypto mascot designed to bring fun and fortune to your wallet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sprite_Cat_logo_11edd40bab.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

