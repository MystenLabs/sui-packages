module 0xd7a3eb43fb6bc2755bde4b19be768762f882766361023164a60e637b6d2227ac::dance {
    struct DANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANCE>(arg0, 9, b"DANCE", b"Dancing Guy", b"Dance to the moon | Website: https://i.pinimg.com/originals/59/87/eb/5987eb0ef1dc3b3ba0492a82808d8177.gif", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/originals/59/87/eb/5987eb0ef1dc3b3ba0492a82808d8177.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

