module 0x7d7b04c92f343296c92f051a954c6bbe49eb4dae175e149ac66c15d5d44aefb6::yaha {
    struct YAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAHA>(arg0, 6, b"YAHA", b"YahaOnSUI", b"Hey, It's Yaha, makin big splashes on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chomp_ddf3156dbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

