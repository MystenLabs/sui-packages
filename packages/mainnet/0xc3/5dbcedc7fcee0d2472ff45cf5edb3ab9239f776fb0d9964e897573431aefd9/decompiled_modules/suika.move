module 0xc35dbcedc7fcee0d2472ff45cf5edb3ab9239f776fb0d9964e897573431aefd9::suika {
    struct SUIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKA>(arg0, 6, b"Suika", b"SUIKA GAME", x"5375696b612047616d6520616c736f206b6e6f776e2061732057617465726d656c6f6e2047616d652e0a546869732067616d65206d656d65636f696e206f666665727320612076617269657479206f662070757a7a6c6573206f662066756e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zn_Q1z_YP_400x400_e1b7437115.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

