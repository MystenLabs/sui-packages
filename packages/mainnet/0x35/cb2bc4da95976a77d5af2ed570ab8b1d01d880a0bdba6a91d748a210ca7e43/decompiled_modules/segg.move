module 0x35cb2bc4da95976a77d5af2ed570ab8b1d01d880a0bdba6a91d748a210ca7e43::segg {
    struct SEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEGG>(arg0, 6, b"SEGG", b"EGG DOG SUI", b"DOG WIF EGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GIP_Alg_WWUAAB_Zwb_986ae38a15.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

