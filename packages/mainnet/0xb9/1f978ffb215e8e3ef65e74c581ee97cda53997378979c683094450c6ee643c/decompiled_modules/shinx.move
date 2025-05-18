module 0xb91f978ffb215e8e3ef65e74c581ee97cda53997378979c683094450c6ee643c::shinx {
    struct SHINX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHINX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHINX>(arg0, 6, b"SHINX", b"POKEMOON SHINX", b"Shinx evolves into Luxio, who evolves into Luxray.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibropep3f7izfyw7g5r3jb44aczmktg2jcjoc4saew3xueahjuc4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHINX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHINX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

