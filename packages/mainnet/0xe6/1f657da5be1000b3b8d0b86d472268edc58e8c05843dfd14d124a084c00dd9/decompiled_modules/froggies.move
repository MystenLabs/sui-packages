module 0xe61f657da5be1000b3b8d0b86d472268edc58e8c05843dfd14d124a084c00dd9::froggies {
    struct FROGGIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGIES>(arg0, 6, b"Froggies", b"Froggie Sui", b"SUI on Froggies !! Make Me Happy Again!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_frogies_775ca2c2ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

