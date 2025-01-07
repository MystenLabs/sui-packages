module 0x27c0309dad3e48be7d576159fd52c39d9fe666240997298f96b7b083bd1db9a5::s707 {
    struct S707 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S707, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S707>(arg0, 6, b"S707", b"Suifies 707", b"Suifies 707 coded", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfdfsf_7f30a431dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S707>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S707>>(v1);
    }

    // decompiled from Move bytecode v6
}

