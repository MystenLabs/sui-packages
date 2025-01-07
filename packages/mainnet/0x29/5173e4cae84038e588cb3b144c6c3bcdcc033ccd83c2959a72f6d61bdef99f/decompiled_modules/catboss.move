module 0x295173e4cae84038e588cb3b144c6c3bcdcc033ccd83c2959a72f6d61bdef99f::catboss {
    struct CATBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBOSS>(arg0, 6, b"CatBoss", b"Cat Boss", b"Everyone is a cat boss, join the cat family and go to the moon together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012748_c15921c3d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

