module 0x6a902425e38051a734261c368e8a3c10442151fc6aac3167229f7cd96912e13d::rhai {
    struct RHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHAI>(arg0, 9, b"RHAI", b"RedHead AI", b"RedHead Girls are beautiful AI | Website: https://api.interestlabs.io/files/c68316d59b743cddcdc873e98b924e7dc703325f48fb953e.jpg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.interestlabs.io/files/c68316d59b743cddcdc873e98b924e7dc703325f48fb953e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

