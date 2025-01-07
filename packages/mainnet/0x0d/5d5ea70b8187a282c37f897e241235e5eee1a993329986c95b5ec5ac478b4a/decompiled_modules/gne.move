module 0xd5d5ea70b8187a282c37f897e241235e5eee1a993329986c95b5ec5ac478b4a::gne {
    struct GNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNE>(arg0, 6, b"GNE", b"Good news, everyone", b"Good news, everyone!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/futurama1_8aa63475f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

