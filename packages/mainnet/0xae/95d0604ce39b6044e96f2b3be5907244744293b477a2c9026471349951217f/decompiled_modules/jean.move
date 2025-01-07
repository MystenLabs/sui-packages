module 0xae95d0604ce39b6044e96f2b3be5907244744293b477a2c9026471349951217f::jean {
    struct JEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEAN>(arg0, 6, b"JEAN", b"Sui Jean", b"Denim on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jean_8258e99dc5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

