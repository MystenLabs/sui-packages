module 0x3f94c4cdcf4deec4c05aa5c2f56af267ce7db367bddec64a193d3ca2cf7fba73::pp {
    struct PP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PP>(arg0, 6, b"PP", b"Pepe Patrick", b"A public display of respect and honor to two internet legends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/raf_360x360_075_t_fafafa_ca443f4786_u3_e0ee1a692c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PP>>(v1);
    }

    // decompiled from Move bytecode v6
}

