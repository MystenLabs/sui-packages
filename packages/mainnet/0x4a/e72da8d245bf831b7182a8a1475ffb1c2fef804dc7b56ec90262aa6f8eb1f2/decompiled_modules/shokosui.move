module 0x4ae72da8d245bf831b7182a8a1475ffb1c2fef804dc7b56ec90262aa6f8eb1f2::shokosui {
    struct SHOKOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOKOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOKOSUI>(arg0, 6, b"SHOKOSUI", b"SHOKO on Sui", b"SHOKOSUI is the New dog of KABOSU MAMA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c2d4799a205040aebc696d679bea3032_973446204b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOKOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOKOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

