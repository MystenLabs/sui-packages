module 0xbc88e0a485e91fb5e0fc87b780d14a2535240b0657b2772ead853475c3d56cb0::goosui {
    struct GOOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOSUI>(arg0, 6, b"GOOSUI", b"gooSUI", b"goosui swam into the endless ocean of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2022_04_27_15_36_18_ca13587330.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

