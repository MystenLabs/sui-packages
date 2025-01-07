module 0x5fc8d91b8848588739d907d682516d7b3f0f568ea81e2d28e6503e777dd3a52d::ecosui {
    struct ECOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECOSUI>(arg0, 6, b"ECOSUI", b"ECOSUISTEM", x"45636f7375697374656d20697320616e20656e7669726f6e6d656e7420776865726520537569206d656d65732077696c6c2067617468657220616e64207075736820537569206d656d657320746f20696d70726f7665207468726f75676820706172746e657273686970732e0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241014_233409_904_0552b7c401.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

