module 0xf28a12005d9f3eaf9db18e228a0c3273b4c74061bfb3e7f65d04c94e6ccd113a::lookbro {
    struct LOOKBRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOKBRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOKBRO>(arg0, 6, b"Lookbro", b"Look Brother", b"Look bro... we don't want you here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dgdfgdfgfdgdfgdfgf_a04849376b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOKBRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOKBRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

