module 0x988be86fa38e4c570e8c465b3a8946b61d647dc45c5ffa1a26e334062095c2e4::leo {
    struct LEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEO>(arg0, 6, b"LEO", b"leopard", b"Hi world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000169115_0f9d4ce6ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

