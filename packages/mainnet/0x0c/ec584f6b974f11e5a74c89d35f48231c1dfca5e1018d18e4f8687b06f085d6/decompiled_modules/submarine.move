module 0xcec584f6b974f11e5a74c89d35f48231c1dfca5e1018d18e4f8687b06f085d6::submarine {
    struct SUBMARINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBMARINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBMARINE>(arg0, 6, b"SUBMARINE", b"Yellow Submarine", b"The \"Yellow Submarine\" symbolizes imagination and unity, creating an atmosphere of friendship and shared adventures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_14_11_59_12_0e19ce4e0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBMARINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBMARINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

