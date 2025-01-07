module 0x79de2e93296143841314832b7356b63ce31603e9a5f5f41e61dbb945d538b038::shokosui {
    struct SHOKOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOKOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOKOSUI>(arg0, 6, b"Shokosui", b"Shoko of Sui", b"New dog of Sui - Shoko!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c2d4799a205040aebc696d679bea3032_67be602657.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOKOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOKOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

