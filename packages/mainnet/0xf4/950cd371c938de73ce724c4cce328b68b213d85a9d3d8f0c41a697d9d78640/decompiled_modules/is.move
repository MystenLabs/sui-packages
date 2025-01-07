module 0xf4950cd371c938de73ce724c4cce328b68b213d85a9d3d8f0c41a697d9d78640::is {
    struct IS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IS>(arg0, 6, b"IS", b"Is", b"... is ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_12_23_173459_947613f833.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IS>>(v1);
    }

    // decompiled from Move bytecode v6
}

