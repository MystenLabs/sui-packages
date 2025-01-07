module 0x4eed111418eeb0c18208a61af8e8a2e699f8dfea6512a564ae489ba0a456f447::shiro {
    struct SHIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIRO>(arg0, 6, b"Shiro", b"Shiro Neko on Sui", b"Shiro Neko, White Cat in Japanese, is embarking on a journey to prove himself in the crypto sphere. Under the mentorship of the legendary Shiba Inu, Shiro learns the ways of blockchain, striving to build his own legacy with $SHIRO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Shiro_Neko_fe19db7a8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

