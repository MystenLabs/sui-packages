module 0x19124a9560535b8b1c565720d05a04880233f6ebb1cb551c90fea5d145f14a7b::suishidog {
    struct SUISHIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIDOG>(arg0, 6, b"SUISHIDOG", b"Suo-ShiDog", x"5468652079756d6d696573742c206a756963696573742c2063757465737420537569736869646f6720697320686572652120476f6e6e61206d616b6520796f7572206d6f75746820616e642077616c6c657473207761746572696a6720666f72206d6f7265206f6620746869732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_20_28_30_e1d39dc429.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

