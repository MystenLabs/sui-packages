module 0x9e259750c26cca814db7d65befc37bb8d648521135d69ce5abf9f16f7dd9cd89::suiperman {
    struct SUIPERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERMAN>(arg0, 6, b"SUIPERMAN", b"Suiper Inu", b"The first superhero meme coin on sui network !!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P3j_E_Vs_x_400x400_c5f950ac51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

