module 0xf8b95f2fca0cb34b13a54e80b82cd2e39c5e198369e6d182e9fbc003cf87eb2d::aipepe {
    struct AIPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPEPE>(arg0, 6, b"AIPEPE", b"Ai Pepe", b"Pepe culture and cutting-edge AI that let you joining a fun, innovative movement where creativity and technology collide", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000041073_6823a9ca06.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

