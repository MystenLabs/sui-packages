module 0x885f96adb2189ee292aad5e74ed4126b48e91893c36dc62fac2c3df4e5ad0eb6::dogf {
    struct DOGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGF>(arg0, 6, b"DogF", b"Dog FLA", b"meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7e96fca5_872f_4d9f_bcc7_462ad770b2aa_cca140c457_033bd6e870.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

