module 0x5d003a9101c5e2cec9149118498b82443355cecd24ec1cbae33a8661ae265f02::goldkedi {
    struct GOLDKEDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDKEDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDKEDI>(arg0, 9, b"goldkedi", b"MEHMETkedi", b"KEDIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1777306322846851073/VunruzU2_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOLDKEDI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDKEDI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDKEDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

