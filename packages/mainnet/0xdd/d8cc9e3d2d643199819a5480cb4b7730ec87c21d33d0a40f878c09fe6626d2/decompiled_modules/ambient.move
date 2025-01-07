module 0xddd8cc9e3d2d643199819a5480cb4b7730ec87c21d33d0a40f878c09fe6626d2::ambient {
    struct AMBIENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMBIENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMBIENT>(arg0, 6, b"AMBIENT", b"Ambient Art Gallery", b"Ambient Art Gallery (AMBIENT)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/54235_d67911f217.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMBIENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMBIENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

