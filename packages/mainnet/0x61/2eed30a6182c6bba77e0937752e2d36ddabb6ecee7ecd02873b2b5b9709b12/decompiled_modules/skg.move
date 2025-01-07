module 0x612eed30a6182c6bba77e0937752e2d36ddabb6ecee7ecd02873b2b5b9709b12::skg {
    struct SKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKG>(arg0, 6, b"SKG", b"Suine kong", b"SUINE is the new masCot of SUIchAin. Be ready for it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sans_titre_6_3ac659aae2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

