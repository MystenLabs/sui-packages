module 0x57dd9bf94ac73eae8097534b80df6c1cc1e38faf3f2063756be7296563ff1684::smurf {
    struct SMURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURF>(arg0, 6, b"SMURF", b"Smurf", b"Small in size, big on memecoin dreams!  all about meme magic!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_fbb1da1d62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

