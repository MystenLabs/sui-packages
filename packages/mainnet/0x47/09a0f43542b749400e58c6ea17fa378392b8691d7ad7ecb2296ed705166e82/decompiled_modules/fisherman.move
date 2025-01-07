module 0x4709a0f43542b749400e58c6ea17fa378392b8691d7ad7ecb2296ed705166e82::fisherman {
    struct FISHERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHERMAN>(arg0, 6, b"FISHERMAN", b"suifisherman.xyz", x"41206669736865726d616e207769746820616e20616d626974696f6e206f66206361746368696e67207768616c6573206f6e200a406d6f766570756d700a207c7c204c697374696e67206f6e20687474703a2f2f6d6f766570756d702e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_W9_QMZ_400x400_ade1101efa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

