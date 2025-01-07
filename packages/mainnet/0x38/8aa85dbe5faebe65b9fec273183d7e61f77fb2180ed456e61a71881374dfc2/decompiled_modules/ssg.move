module 0x388aa85dbe5faebe65b9fec273183d7e61f77fb2180ed456e61a71881374dfc2::ssg {
    struct SSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSG>(arg0, 6, b"SSG", b"SUI GHOST", b"Im behind you bro!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_29_14_11_43_f8fe408361.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

