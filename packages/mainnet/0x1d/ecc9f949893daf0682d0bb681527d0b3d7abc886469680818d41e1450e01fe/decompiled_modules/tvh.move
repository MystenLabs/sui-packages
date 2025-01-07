module 0x1decc9f949893daf0682d0bb681527d0b3d7abc886469680818d41e1450e01fe::tvh {
    struct TVH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TVH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TVH>(arg0, 6, b"TVH", b"Trump VS Harris", x"54686520636f756e74646f776e20746f20746865207570636f6d696e6720555320707265736964656e7469616c20656c656374696f6e206f6e204e6f76656d626572203574682c2077686f20646f20796f7520737570706f72743f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_a_17397812_4_c3315fe1ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TVH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TVH>>(v1);
    }

    // decompiled from Move bytecode v6
}

