module 0x4971efe4d35b4d86bdca80bc7e37164eee66c099a1a7501773403cde2208faf8::gib {
    struct GIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIB>(arg0, 6, b"GIB", b"GIB On Sui", b"GIB Token - The wildest crypto meme adventure! Explore our messy room, navigating the maze of jests and disorder. Moon's the goal, Lambo's the dream!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/banner_1d8b2aa461.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

